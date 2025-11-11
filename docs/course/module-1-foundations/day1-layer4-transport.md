# 🧱 OSI Layer 4 – Transport Layer

> _“The Transport Layer is the traffic cop of the cloud — directing packets, enforcing rules, and ensuring safe delivery.”_

## 🔍 What It Is
Layer 4 of the OSI model ensures **end-to-end delivery** of data between systems. It handles segmentation, flow control, and error recovery — making sure packets arrive intact and in order.

## 🛡️ Cloud Security Controls at Layer 4

| Control | Description | Cloud Examples |
|--------|-------------|----------------|
| **Security Groups** | Stateful firewalls that allow/deny traffic based on port, protocol, and source/destination. | AWS Security Groups, Azure NSGs |
| **Network ACLs (NACLs)** | Stateless rules applied at subnet level to control traffic. | AWS NACLs |
| **Firewall Rules** | Explicit Layer 4 rules for VMs or containers. | GCP VPC Firewall, Azure Firewall |
| **Port Restrictions** | Limiting access to sensitive ports (e.g., TCP 22, TCP 3306). | Terraform security group modules |

## 🧠 Architect’s Responsibilities at Layer 4

- Design **least privilege network access** using port/protocol rules.
- Segment workloads by **application tier** (e.g., web → app → DB) with port-based controls.
- Enforce **stateful inspection** using Security Groups.
- Use **stateless filters** (NACLs) for broad subnet-level control.
- Monitor **transport-level traffic** for anomalies (e.g., port scans, failed connections).
- Automate firewall rules via IaC (Terraform, Bicep).

## 🧪 Mini-Lab (AWS CLI Example)

```bash
# Create a security group
aws ec2 create-security-group \
  --group-name web-sg \
  --description "Web tier SG"

# Allow HTTPS (TCP 443)
aws ec2 authorize-security-group-ingress \
  --group-name web-sg \
  --protocol tcp \
  --port 443 \
  --cidr 0.0.0.0/0
✅ Review Checklist
[ ] Explain TCP vs UDP and their roles in cloud apps.

[ ] Configure Security Groups for least privilege access.

[ ] Use NACLs to restrict subnet-level traffic.

[ ] Automate Layer 4 controls using CLI or Terraform.
