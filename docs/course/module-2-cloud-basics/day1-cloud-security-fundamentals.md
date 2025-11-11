

# ☁️ Module 2 → Day 1 – Cloud Security Fundamentals  

> _“Every kingdom guards its borders differently — but the law of Zero Trust unites them all.”_  

---
## 🧠 1. Analogy – Three Kingdoms, One Law

Picture a world of three powerful nations:

- **AWS** – fast, industrial, pragmatic → the **engineer’s kingdom**.  
- **Azure** – integrated, policy-driven → the **bureaucrat’s kingdom**.  
- **GCP** – data-centric, automated → the **scientist’s kingdom**.

Each kingdom has its own guards (security services), rulebooks (policies), and patrol systems (monitoring).  
Your job as a **Multi-Cloud Security Architect** is to become the ambassador — translating laws so that travelers (applications) move safely between borders.

---

## 🧩 2. The Shared Responsibility Model

| Layer | Cloud Provider | Customer Responsibility | Provider Responsibility |
|-------|----------------|--------------------------|--------------------------|
| **Physical** | AWS / Azure / GCP Data Centers | None | Power, Cooling, Physical Access |
| **Network & Host** | VPC, VNets, VPCs | Firewall rules, routing tables, OS patching | Underlying hardware security |
| **Identity & Access** | IAM, RBAC | Defining roles, MFA, least privilege | Authentication frameworks |
| **Application & Data** | S3, Blob, Cloud Storage | Encryption, data classification, access logging | Storage redundancy & availability |

**Golden Rule:**  
> The provider secures *the cloud*; you secure *what’s in the cloud.*

---

## ⚙️ 3. Core Security Services at a Glance

| Domain | AWS | Azure | GCP |
|---------|-----|--------|------|
| Identity & Access | IAM | Entra ID (Azure AD) | IAM |
| Network Protection | VPC Security Groups | Network Security Groups | VPC Firewall Rules |
| Threat Detection | GuardDuty | Defender for Cloud | Security Command Center |
| Key Management | KMS | Key Vault | Cloud KMS |
| Logging & Audit | CloudTrail / CloudWatch | Activity Log / Monitor | Cloud Audit Logs / Operations Suite |
| Compliance Center | AWS Artifact | Compliance Manager | Assured Workloads |

---

## 🧩 4. Threat Models in Each Cloud

| Platform | Common Threat | Example Mitigation |
|-----------|---------------|--------------------|
| **AWS** | Over-permissive IAM roles | IAM Access Analyzer, least privilege policies |
| **Azure** | Publicly exposed storage blobs | Private Endpoints, Storage Firewall |
| **GCP** | Misconfigured service accounts | IAM Recommender, Workload Identity Pools |
| **All Clouds** | Data exfiltration via open ports | Zero Trust networking, micro-segmentation |

---

## 🧪 5. Hands-On Mini-Lab – Your First Secure Instance Trio

### Objective
Deploy one virtual machine on each cloud using the **same baseline security**:

| Baseline Control | Implementation |
|-------------------|----------------|
| **Least Privilege Access** | Create a restricted IAM role / service principal |
| **Network Isolation** | Place in private subnet / VNet / VPC |
| **Encryption** | Enable disk encryption (KMS / Key Vault / Cloud KMS) |
| **Logging** | Turn on CloudTrail / Monitor / Cloud Audit Logs |

### AWS CLI
```bash
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --subnet-id <private-subnet-id> \
  --iam-instance-profile Name=readonly-profile \
  --key-name mykeypair
Azure CLI
bash
Copy code
az vm create \
  --resource-group SecLabRG \
  --name SecureVM \
  --image UbuntuLTS \
  --vnet-name PrivateVNet \
  --subnet PrivateSubnet \
  --admin-username cloudlab \
  --generate-ssh-keys
GCP CLI
bash
Copy code
gcloud compute instances create secure-vm \
  --machine-type=e2-micro \
  --subnet=private-subnet \
  --no-address \
  --scopes=https://www.googleapis.com/auth/logging.write
✅ Expected Outcome:
You now have three isolated, encrypted, logged instances, each adhering to a consistent security baseline — your first cross-cloud architecture.

🧩 6. Architect’s Perspective
As a Multi-Cloud Architect:

Standardize security controls using IaC (Terraform).

Build a cloud security baseline template usable on any provider.

Centralize monitoring via SIEM (Sentinel, Chronicle, Splunk).

Use policy-as-code tools (Azure Policy, OPA, Conftest).

Maintain least privilege roles across federated accounts.

ASCII Blueprint:

css
Copy code
          [Central Identity Broker]
                    │
      ┌─────────────┼─────────────┐
      ▼             ▼             ▼
 [AWS Account] [Azure Subscription] [GCP Project]
      │             │             │
 [Baseline Controls → IaC Templates → SIEM Logs]
🧩 7. Common Pitfalls
Mistake	Impact	Fix
Ignoring shared responsibility	Misplaced blame on provider	Define ownership matrix
Inconsistent security posture	Different rules per cloud	Create baseline Terraform module
Lack of visibility	Delayed incident response	Centralize logging / SIEM
Over-provisioned access	Increased blast radius	Apply least privilege and temporary roles

✅ 8. Review Checklist
 Explain Shared Responsibility Model for AWS, Azure, GCP

 Deploy baseline secure instances in each cloud

 Compare security services across clouds

 Define your own IaC baseline template

 Commit Day 1 notes to GitHub

🧭 9. Next Step
Proceed to Module 2 → Day 2 – Cloud Networking Security Deep Dive
where you’ll design multi-cloud network peering, private endpoints, and cross-cloud firewall rules using Terraform and CLI.
