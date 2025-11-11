# 🧍‍♂️ Module 1 → Day 3 – Identity & Access Management (IAM) Fundamentals

> _“If networks move data and systems store data, IAM decides **who gets the keys to the kingdom**.”_  
> _The cloud’s true perimeter is not a firewall — it’s identity._

---

## 🧠 1. Analogy – The Digital Passport System

Imagine the entire cloud world as a **network of airports**:  
- **Users** = travelers.  
- **Roles** = temporary visitor badges (like business or VIP passes).  
- **Policies** = visa rules (what you’re allowed to do).  
- **MFA** = fingerprint scanner at the gate.  
- **Federation (SSO)** = using one passport across multiple countries.  

Each cloud provider runs its own airport:
- AWS = “Amazon International”  
- Azure = “Microsoft Airways”  
- GCP = “Google Global Terminal”  

Your job as a Cloud Security Architect is to **harmonize these airports under one identity treaty** — a secure federation.

---

## 🔐 2. IAM Building Blocks

| Concept | Description | Analogy |
|----------|--------------|----------|
| **User** | Represents a human or system needing access. | A person holding a passport. |
| **Group** | Collection of users with similar access. | Airline lounge — all members share benefits. |
| **Role** | Temporary permission set assumed by trusted entities. | Airport visitor badge or pilot clearance. |
| **Policy** | JSON or YAML document defining allowed actions. | Immigration rulebook. |
| **MFA (Multi-Factor Auth)** | Adds verification layers. | Passport + fingerprint scan. |
| **Federation / SSO** | Identity shared across systems. | Visa-free travel across countries. |

---

## ☁️ 3. IAM Across AWS, Azure & GCP

| Area | AWS | Azure | GCP |
|------|-----|--------|------|
| Identity Service | IAM | Azure AD / Entra ID | IAM |
| Role-Based Access | IAM Roles / Policies | RBAC / Roles | IAM Roles / Policies |
| Temporary Access | STS AssumeRole | Privileged Identity Mgmt | Service Account Keys |
| Policy Format | JSON | JSON / YAML | YAML |
| MFA Integration | AWS MFA | Microsoft Authenticator | Google Auth |
| Federation | SAML / OIDC | SAML / OIDC | SAML / OIDC |

---

## 🧩 4. Key Principle – *Least Privilege Access Model*

> “If a user can accidentally delete production, your IAM model has failed.”

### Golden Rules:
1. **Start with deny, then allow** explicitly.  
2. Grant privileges to **roles**, not individuals.  
3. Use **conditions** (time, IP, tags) for context-aware access.  
4. Rotate and expire credentials automatically.  
5. Audit permissions continuously.  

---

## 🧪 5. Hands-On Mini-Lab — IAM Simulation (AWS CLI)

### Objective
Create a user, assign a policy, then test least privilege.

```bash
# 1. Create a user
aws iam create-user --user-name analyst

# 2. Attach read-only policy
aws iam attach-user-policy \
  --user-name analyst \
  --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

# 3. Create access key (for test)
aws iam create-access-key --user-name analyst

# 4. List permissions
aws iam list-attached-user-policies --user-name analyst

# 5. Try a denied action (e.g., creating bucket)
aws s3 mb s3://my-secret-bucket --profile analyst
# Expect: AccessDenied
✅ Expected Outcome:
The analyst can view resources but cannot modify or create them.

That’s least privilege in action.

🧠 6. The Architect’s View
A Multi-Cloud Security Architect must design identity like a unified nervous system:

Central Directory: Sync users via Azure AD or Okta across clouds.

Federation Layer: Implement SAML/OIDC trust between clouds.

Context-Aware Access: Combine device health, location, and user role.

Automation: Use Terraform or AWS CloudFormation for IAM provisioning.

Continuous Validation: Connect logs to SIEM → detect anomalies (e.g., impossible travel logins).

ASCII View
css
Copy code
[User]──►[Central Directory]──►[Federation Broker]
                   │
   ┌───────────────┼────────────────┐
   ▼               ▼                ▼
[AWS IAM]     [Azure AD RBAC]     [GCP IAM]
🧾 7. Best Practices Summary
Practice	Description
Identity Federation	Use centralized identity (Azure AD / Okta).
MFA Everywhere	Enforce MFA for all interactive logins.
Service Accounts Isolation	No shared keys — unique per workload.
Rotate Keys	Enforce 90-day (or shorter) rotation policies.
Use IAM Analyzer	Detect unused permissions automatically.

✅ 8. Review Checklist
 Explain IAM components using analogies

 Practice AWS CLI IAM commands

 Design least privilege access

 Sketch multi-cloud IAM federation diagram

 Commit to GitHub and document learnings

🧭 9. Next Step
Proceed to Day 4 – Encryption and Key Management (KMS & Data Protection)
to learn how cryptography protects your cloud’s secrets and how key lifecycles are governed across AWS, Azure, and GCP.
