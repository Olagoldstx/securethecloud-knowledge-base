# 🛡️ Module 1 → Day 5 – Zero Trust Networking & Micro-Segmentation

> _“Assume breach. Verify explicitly. Grant least privilege. That is the doctrine of modern cloud defense.”_

---

## 🧠 1. Analogy – The Castle with Rooms

Traditional security was like a **castle with a moat**: once you crossed the drawbridge, you roamed freely.  
Zero Trust redesigns that castle into **thousands of rooms**, each with its own lock, camera, and ID scanner.  
Even the king must badge in.

**Goal:** Every packet, process, and identity must prove who it is, every time, everywhere.

---

## 🧩 2. Zero Trust Core Principles

| Pillar | Description | Analogy |
|---------|--------------|---------|
| **Verify Explicitly** | Authenticate & authorize continuously. | ID scan at every door. |
| **Least Privilege Access** | Limit scope, time, and context. | Temporary visitor badge. |
| **Assume Breach** | Design as if attacker is already inside. | Guard every hallway, not just the gate. |

---

## 🌐 3. From Perimeter to Policy – the Paradigm Shift
| Old Model | New Model |
|------------|-----------|
| Trust inside network | Trust nothing by default |
| Implicit VPN trust | Continuous identity verification |
| IP-based controls | Identity + context + device health |
| Central firewall | Distributed policy enforcement |

---

## ⚙️ 4. Micro-Segmentation in Practice

**Concept:** Divide workloads into isolated zones based on function, data sensitivity, or team ownership.

| Type | Example | Tooling |
|------|----------|---------|
| **Network Segmentation** | Split VPCs, subnets | AWS VPC, Azure VNets, GCP VPCs |
| **Application Segmentation** | Tier-based ACLs | Security Groups, NSGs |
| **Identity Segmentation** | Role-based policies | IAM Roles, RBAC |
| **Process Segmentation** | Container isolation | Kubernetes Network Policies |

ASCII View:
[Internet]
│
[Edge WAF]
│
┌───────────────┬───────────────┐
▼ ▼ ▼
[Web Tier] [App Tier] [DB Tier]
│ │ │
└──► Logs / SIEM / Monitoring

pgsql
Copy code

---

## 🧪 5. Hands-On Mini-Lab – Zero Trust Simulation

### Objective
Restrict communication between web and database tiers using UFW and Security Groups.

```bash
# View interfaces and IPs
ip a

# Deny all by default
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow only HTTPS from Web to App
sudo ufw allow in on eth0 to any port 443 proto tcp comment 'Web→App TLS only'

# Deny DB access from Web
sudo ufw deny in on eth0 to any port 3306 comment 'Block MySQL to DB'

sudo ufw status verbose
✅ Expected Outcome:
Only encrypted web traffic passes; direct DB queries from web tier are blocked — a micro-segment success.

☁️ 6. Zero Trust Across Clouds
Concept	AWS	Azure	GCP
Policy Enforcement Points	AWS PrivateLink, VPC Endpoints	Azure Firewall / Private Link	VPC Service Controls
Identity Signal	AWS STS + IAM Context	Azure Entra ID + Conditional Access	GCP Context-Aware Access
Micro-Segmentation	Security Groups + Network ACLs	NSGs + App Security Groups	VPC Firewall Rules
Visibility & SIEM	GuardDuty / CloudWatch	Defender / Sentinel	SCC / Chronicle

🧠 7. Architect’s View – Designing Zero Trust Blueprints
Centralize identity & policy across clouds.

Enforce encryption at every hop.

Build per-app isolation using segmented VPCs/VNets.

Feed telemetry into SIEM for adaptive policies.

Automate using Terraform + policy-as-code.

ASCII Flow:

css
Copy code
[User] → [IdP + MFA] → [Policy Engine] → [Enforcement Point] → [Resource]
                    ↘──────── Logs / SIEM / SOAR
⚠️ 8. Common Pitfalls
Mistake	Result	Fix
Flat network architecture	Attack spreads laterally	Segment tiers + IAM per app
Overly complex rules	Operational blindness	Use labels / tags for automation
Ignoring east-west traffic	Hidden breaches	Deploy internal firewalls or micro agents
Missing visibility	Blind spots in Zero Trust	Stream logs to SIEM in real time

✅ 9. Review Checklist
 Explain Zero Trust principles in your own words

 Configure UFW to enforce micro-segmentation

 Draw Zero Trust dataflow diagram

 Map Zero Trust controls across AWS, Azure, GCP

 Commit Day 5 notes to GitHub

🧭 10. Next Step
Proceed to Module 2 → Day 1 – Cloud Security Fundamentals (AWS, Azure, GCP Intro)
to begin your journey into multi-cloud security services and shared-responsibility models.
