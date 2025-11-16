variable "region" {
  description = "AWS region where Identity Center is managed"
  type        = string
  default     = "us-east-1"
}

variable "permission_set_name" {
  description = "Name of the Permission Set"
  type        = string
  default     = "SecurityArchitect"
}

variable "session_duration" {
  description = "Duration of AWS SSO sessions (ISO-8601)"
  type        = string
  default     = "PT4H"
}
