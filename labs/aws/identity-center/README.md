# Lab 02 — AWS Identity Center Permission Set (Security Architect)

This lab creates an AWS IAM Identity Center Permission Set for the **Security Architect** role and
attaches the AWS managed `SecurityAudit` policy plus a simple inline policy for viewing billing.

## Prereqs
- AWS Identity Center enabled and federated with Microsoft Entra ID.
- AWS CLI auth via `aws-vault` profile \`cloudlab-user\`.

## Usage
```bash
terraform init
aws-vault exec cloudlab-user -- terraform plan
aws-vault exec cloudlab-user -- terraform apply
