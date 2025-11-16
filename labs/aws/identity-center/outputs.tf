output "permission_set_arn" {
  description = "ARN of the Security Architect permission set"
  value       = aws_ssoadmin_permission_set.security_architect.arn
}

output "instance_arn" {
  description = "SSO Instance ARN used"
  value       = local.instance_arn
}
