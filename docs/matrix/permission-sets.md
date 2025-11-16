# AWS IAM Identity Center — Enterprise Permission Set Matrix
_Authoritative catalog for SecureTheCloud. Use this as your baseline across accounts and environments._

## 🔎 How to Use
- Each **Permission Set** maps to **one IAM Role per account** where assigned.
- Users are assigned via **Azure Entra Groups** (SCIM-provisioned) → AWS SSO.
- Start with **dev/sandbox** scope, then graduate to **prod** after peer review.

---

## 🧩 Matrix (v1.0)

| Permission Set          | Purpose / Scope                                                                 | AWS Policies (Managed)                 | Inline Additions (Starter)                                                                                                             | Entra Group (Suggested)            | Notes / Risks |
|-------------------------|----------------------------------------------------------------------------------|----------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|---------------|
| **AdministratorAccess** | Break‑glass full admin. Strict MFA, short sessions, approver required.          | `AdministratorAccess`                  | None                                                                                                                                   | `GRP-AWS-Admin`                    | Use sparingly; log/alert when assumed. Require ticket. |
| **PowerUser**           | Build/manage infra without IAM admin.                                           | `PowerUserAccess`                      | None                                                                                                                                   | `GRP-AWS-PowerUser`                | Cannot manage IAM directly; good for platform teams. |
| **SecurityArchitect**   | Cross‑account security read with some ops.                                      | `SecurityAudit`                        | (Optional) Cost visibility: `ce:Get*`, `cur:Describe*`, `budgets:ViewBudget`                                                           | `GRP-AWS-SecurityArchitect`        | Prefer read‑only; add writes per change control. |
| **ReadOnly**            | Universal read for troubleshooting / audits.                                    | `ReadOnlyAccess`                       | None                                                                                                                                   | `GRP-AWS-ReadOnly`                 | Great default; pairs with service-specific narrow writes. |
| **BillingAdmin**        | FinOps admins: billing console + CUR/CE/budgets.                                | _See note_                              | `aws-portal:View*`, `aws-portal:Modify*`, `ce:*`, `cur:*`, `budgets:*`                                                                 | `GRP-AWS-BillingAdmin`             | Requires “IAM access to Billing” enabled for the account. Validate exact actions in your org. |
| **BillingReadOnly**     | FinOps read-only: billing, CE, CUR, budgets.                                    | _See note_                              | `aws-portal:View*`, `ce:Get*`, `cur:Describe*`, `budgets:ViewBudget`                                                                   | `GRP-AWS-BillingRO`                | Safe default for finance viewers. |
| **NetworkAdmin**        | VPC/TGW/VPN/Routes/DNS admin. No instance lifecycle by default.                 | (Start from `ReadOnlyAccess`)          | Allow selected EC2(VPC) + TGW + VPC endpoints + Route53 changes (see starter inline below)                                             | `GRP-AWS-NetworkAdmin`             | Separate “compute admin” from “network admin.” |
| **IncidentResponder**   | Read access to logs, trails, findings; limited containment if approved.          | `SecurityAudit`                        | `logs:Get*`,`logs:FilterLogEvents`,`cloudtrail:LookupEvents`,`guardduty:Get*`,`securityhub:Get*`,`s3:GetObject` on log buckets        | `GRP-AWS-IncidentResponder`        | Add isolation runbooks as separate, time‑bound roles. |
| **SupportEngineer**     | AWS Support Center interaction and case management.                              | `AWSSupportAccess`                     | None                                                                                                                                   | `GRP-AWS-Support`                  | Least privilege for support workflows. |
| **DevOpsEngineer**      | CI/CD & service teams with infra control; no IAM admin.                         | `PowerUserAccess`                      | Optional service-scoped writes                                                                                                         | `GRP-AWS-DevOps`                   | Consider per‑account / per‑env variants. |
| **KubernetesAdmin**     | EKS admin on AWS side. Needs cluster RBAC mapping separately (aws‑auth CM).     | _See note_                              | Typically `AmazonEKSClusterPolicy` + `AmazonEKSServicePolicy` + `ec2:Describe*` + `iam:PassRole` for EKS roles                         | `GRP-AWS-K8sAdmin`                 | Also map role → `system:masters` in EKS (cluster‑level). |

> **Notes:**  
> • Policy names can vary by region and AWS updates; verify managed policy names in your account.  
> • For **Billing** permission sets: IAM access to the Billing console must be enabled for the account.  
> • EKS admin requires **two layers**: AWS‑side IAM permissions **and** Kubernetes RBAC mapping in `aws-auth` ConfigMap.

---

## 🧱 Starter Inline Policies (Snippets)

### Billing (Admin)
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "aws-portal:View*",
      "aws-portal:Modify*",
      "ce:*",
      "cur:*",
      "budgets:*"
    ],
    "Resource": "*"
  }]
}
Billing (Read‑Only)
json
Copy code
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "aws-portal:View*",
      "ce:Get*",
      "cur:Describe*",
      "budgets:ViewBudget"
    ],
    "Resource": "*"
  }]
}
Incident Responder (Read log sources)
json
Copy code
{
  "Version": "2012-10-17",
  "Statement": [
    { "Effect": "Allow", "Action": ["logs:Describe*","logs:Get*","logs:FilterLogEvents"], "Resource": "*" },
    { "Effect": "Allow", "Action": ["cloudtrail:LookupEvents"], "Resource": "*" },
    { "Effect": "Allow", "Action": ["guardduty:Get*","guardduty:List*"], "Resource": "*" },
    { "Effect": "Allow", "Action": ["securityhub:Get*","securityhub:List*"], "Resource": "*" },
    { "Effect": "Allow", "Action": ["s3:GetObject","s3:GetBucketLocation"], "Resource": "arn:aws:s3:::<LOG_BUCKET>/*" }
  ]
}
Network Admin (Starter — adjust carefully)
json
Copy code
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "ec2:CreateVpc","ec2:DeleteVpc","ec2:CreateSubnet","ec2:DeleteSubnet",
      "ec2:CreateRouteTable","ec2:AssociateRouteTable","ec2:CreateRoute","ec2:DeleteRoute",
      "ec2:CreateTransitGateway*","ec2:DeleteTransitGateway*",
      "ec2:CreateVpcEndpoint*","ec2:DeleteVpcEndpoints",
      "ec2:CreateCustomerGateway","ec2:CreateVpnGateway","ec2:AttachVpnGateway","ec2:CreateVpnConnection",
      "route53:ChangeResourceRecordSets","route53:GetHostedZone","route53:ListHostedZonesByName"
    ],
    "Resource": "*"
  }]
}
🧭 Group Naming (Azure Entra)
Use predictable group names to drive SCIM and AWS assignments:
GRP-AWS-<PermissionSet> (global)
GRP-AWS-<AccountAlias>-<PermissionSet> (account-scoped)
GRP-AWS-<Env>-<PermissionSet> (env-scoped, e.g., DEV, PROD)
Choose one convention and stick to it org‑wide.
🔐 Guardrails
Enforce MFA and Conditional Access in Entra for all AWS apps.
Use short session durations for admin/break‑glass.
Require ticket numbers (tag on session) for elevated roles.
Review CloudTrail + Access Analyzer for role misuse.
Use permission boundaries for custom builders if needed.
