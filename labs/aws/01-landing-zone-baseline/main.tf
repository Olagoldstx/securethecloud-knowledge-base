locals {
  trail_name = "stc-org-trail"
  tags = {
    owner      = "Olagoldstx"
    env        = "lab"
    data_class = "audit"
    system     = "securethecloud"
  }
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

# ---------- KMS for logging (GLOBAL service principals) ----------
data "aws_iam_policy_document" "kms_logs" {
  statement {
    sid     = "EnableRootUse"
    actions = ["kms:*"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    resources = ["*"]
  }

  # CloudTrail: GLOBAL principal only
  statement {
    sid     = "AllowCloudTrailUse"
    actions = ["kms:Decrypt", "kms:GenerateDataKey*"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:${data.aws_partition.current.partition}:cloudtrail:${var.region}:${var.account_id}:trail/${local.trail_name}"
      ]
    }
  }

  # AWS Config: GLOBAL principal
  statement {
    sid     = "AllowConfigUse"
    actions = ["kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey*", "kms:DescribeKey"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["*"]
  }
}

resource "aws_kms_key" "logs" {
  description         = "KMS key for CloudTrail and AWS Config logs"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms_logs.json
  tags                = local.tags
}

resource "aws_kms_alias" "logs" {
  name          = "alias/stc/logs"
  target_key_id = aws_kms_key.logs.key_id
}

# ---------- S3 bucket for central logs ----------
resource "aws_s3_bucket" "logs" {
  bucket = var.log_bucket_name
  tags   = local.tags
}

resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule { object_ownership = "BucketOwnerEnforced" }
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.logs.arn
    }
  }
}

# ---------- Bucket policy (BucketOwnerEnforced + "cloudtrail" prefix) ----------
data "aws_iam_policy_document" "log_bucket" {
  # Allow CloudTrail to write under cloudtrail/AWSLogs/<acct>/...
  statement {
    sid = "AWSCloudTrailWrite"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.logs.arn}/cloudtrail/AWSLogs/${var.account_id}/*"]
  }

  # Conservative ACL check (safe even with ObjectOwnership=BucketOwnerEnforced)
  statement {
    sid = "AWSCloudTrailAclCheck"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.logs.arn]
  }

  # Allow AWS Config to write snapshots/notifications
  statement {
    sid = "AWSConfigWrite"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.logs.arn}/AWSLogs/${var.account_id}/Config/*"]
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.id
  policy = data.aws_iam_policy_document.log_bucket.json
}

# ---------- CloudTrail (multi-region) ----------
resource "aws_cloudtrail" "this" {
  name                          = local.trail_name
  s3_bucket_name                = aws_s3_bucket.logs.bucket
  kms_key_id                    = aws_kms_key.logs.arn
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  s3_key_prefix                 = "cloudtrail"
  tags                          = local.tags
}

# ---------- AWS Config (use service-linked role; no custom role) ----------
