data "aws_ssoadmin_instances" "this" {}

locals {
  instance_arn = data.aws_ssoadmin_instances.this.arns[0]
  tags = {
    owner  = "Olagoldstx"
    env    = "lab"
    system = "securethecloud"
    role   = "security-architect"
  }
}

resource "aws_ssoadmin_permission_set" "security_architect" {
  name         = var.permission_set_name
  description  = "Permission set for Security Architect role"
  instance_arn = local.instance_arn

  session_duration = var.session_duration

  relay_state = "https://console.aws.amazon.com/"

  tags = local.tags
}

resource "aws_ssoadmin_managed_policy_attachment" "security_audit" {
  instance_arn       = local.instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
  permission_set_arn = aws_ssoadmin_permission_set.security_architect.arn
}

data "aws_iam_policy_document" "inline" {
  statement {
    sid    = "ViewBillingConsole"
    effect = "Allow"

    actions = [
      "aws-portal:ViewBilling",
      "aws-portal:ViewUsage"
    ]

    resources = ["*"]
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "security_architect_inline" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.security_architect.arn
  inline_policy      = data.aws_iam_policy_document.inline.json
}
