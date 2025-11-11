variable "aws_profile" {
  description = "AWS CLI profile name (SSO-backed)"
  type        = string
  default     = "cloudlab-user"
}

variable "region" {
  description = "Primary AWS region"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "Target AWS account ID"
  type        = string
  default     = "764265373335"
}

variable "log_bucket_name" {
  description = "Global unique S3 bucket name for centralized logs"
  type        = string
  default     = "stc-central-logs-764265373335"
}
