output "trail_arn" { value = aws_cloudtrail.this.arn }
output "logs_bucket" { value = aws_s3_bucket.logs.bucket }
output "kms_key_arn" { value = aws_kms_key.logs.arn }
