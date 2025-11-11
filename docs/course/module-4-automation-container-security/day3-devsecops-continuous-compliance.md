# 🚀 Module 4 → Day 3 – DevSecOps Pipelines & Continuous Compliance  

> _“DevSecOps is not a tool. It’s a nervous system — sensing, reacting, and healing before damage occurs.”_

---

## 🧠 1. Analogy – The Self-Healing Factory  

Imagine a **factory** where every robot:  
- **Self-inspects** before assembling parts.  
- **Rejects bad materials** automatically.  
- **Stops the line** if something unsafe happens.  

That’s DevSecOps — a production line where **security is continuous**, not an afterthought.  

---

## 🧩 2. CI/CD + Security = DevSecOps  

| Stage | Security Control | Example Tool |
|---|---|---|
| **Plan** | IaC scanning | Checkov, tfsec |
| **Build** | Dependency scanning | Snyk, Grype |
| **Test** | Unit + security tests | pytest, Bandit |
| **Sign** | Artifact integrity | Cosign, Sigstore |
| **Deploy** | Admission policy | OPA, Kyverno |
| **Monitor** | Drift detection | Falco, Cloud Custodian |

---

## ⚙️ 3. Pipeline Blueprint (GitHub Actions / GitLab CI)  

ASCII Flow:
[Commit Code]
│
[Trigger Pipeline]
│
┌─────────────┬─────────────┬─────────────┐
│ IaC Scan │ Image Scan │ Secret Scan │
└─────────────┴─────────────┴─────────────┘
│
[Policy Gate (OPA)]
│
[Build & Sign Artifact]
│
[Deploy to Cluster (ArgoCD)]
│
[Continuous Compliance Scan]

yaml
Copy code

---

## 🧪 4. Hands-On Lab – Build a Secure CI/CD Pipeline  

### 4.1 GitHub Actions Workflow Example

```yaml
name: devsecops-pipeline

on:
  push:
    branches: [ main ]

jobs:
  build-test-scan:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: IaC Security Scan
      uses: bridgecrewio/checkov-action@master
      with:
        directory: .

    - name: Build Docker Image
      run: docker build -t ${{ github.repository }}:${{ github.sha }} .

    - name: Vulnerability Scan
      uses: aquasecurity/trivy-action@master
      with:
        image-ref: ${{ github.repository }}:${{ github.sha }}

    - name: Sign Image
      run: |
        cosign sign --key cosign.key ${{ github.repository }}:${{ github.sha }}

    - name: Policy Check (Conftest)
      run: conftest test .

    - name: Deploy via ArgoCD
      run: |
        kubectl apply -f manifests/
        argocd app sync my-app
✅ This pipeline automatically fails if IaC or image scans fail — no human intervention.

4.2 Add Continuous Compliance (Cloud Custodian / Steampipe)
Cloud Custodian Policy Example – Ensure all S3 buckets have encryption:

yaml
Copy code
policies:
  - name: s3-bucket-encryption
    resource: aws.s3
    filters:
      - type: encryption
        state: false
    actions:
      - type: set-bucket-encryption
        enabled: true
Steampipe SQL Query Example:

sql
Copy code
SELECT name, encryption_at_rest_enabled
FROM aws_s3_bucket
WHERE encryption_at_rest_enabled = false;
✅ Use scheduled jobs to scan live cloud environments daily and enforce compliance automatically.

🧩 5. Terraform + GitOps Security Combo
Pipeline-triggered Terraform plan:

bash
Copy code
terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform show -json tfplan | conftest test -
✅ Prevents any misconfigured resource from being deployed (e.g., public S3 buckets or open ports).

🧠 6. Enforce Security in GitOps Deployments (ArgoCD + OPA)
Add OPA policies as a sync hook in ArgoCD:

yaml
Copy code
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: secure-app
spec:
  source:
    repoURL: 'https://github.com/cloudlab/secure-app'
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
  hooks:
  - exec:
      command: ["conftest", "test", "."]
✅ No manifest gets deployed unless it passes your compliance checks.

📊 7. Compliance Reporting Dashboard
Framework	Purpose	Integration
CIS Benchmarks	Security baseline for cloud	kube-bench, Prowler
NIST 800-53	Fed compliance mapping	Cloud Custodian
SOC 2 / ISO 27001	Business compliance	Audit reports via SIEM
PCI-DSS	Payment security	GuardDuty + Macie
HIPAA / HITRUST	Healthcare data	Config + Security Hub

Use Steampipe dashboards to query all compliance status across AWS, Azure, and GCP in one view.

⚠️ 8. Common Pitfalls
Pitfall	Impact	Fix
Security scans run post-deploy	Late detection	Shift-left — scan on commit
Manual approvals	Pipeline bottlenecks	Use automated gates
Ignoring IaC drift	Silent misconfigs	Add daily drift scans
Mutable images	Compromised integrity	Sign every build
Ignored alerts	Alert fatigue	Tune severity thresholds

✅ 9. Review Checklist
 Build and scan containers automatically

 Integrate IaC + OPA + Trivy in CI/CD

 Implement Cloud Custodian policies

 Generate compliance dashboards

 Sign all images with Cosign

 Commit pipeline YAML and IaC checks to GitHub

🧭 10. Next Step
Proceed to Module 4 → Day 4 – Continuous Threat Detection & Response (Cloud SOC),
where your pipelines evolve into self-defending systems that detect, isolate, and respond to live cloud threats in real time.
