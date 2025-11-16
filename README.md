<p align="center">
  <img src="assets/securethecloud-banner-dark.png" alt="SecureTheCloud Banner" width="620">
</p>

<h1 align="center">SecureTheCloud Knowledge Base</h1>

<p align="center">
  <strong>Your Living Multi-Cloud Security Playbook — Theory ➜ Architecture ➜ Hands-On Labs.</strong>
</p>

<p align="center">
  <a href="https://securethecloud.dev">
    <img src="https://img.shields.io/badge/Site-SecureTheCloud.dev-00bcd4?style=for-the-badge" alt="Site">
  </a>
  <a href="https://github.com/Olagoldstx">
    <img src="https://img.shields.io/badge/GitHub-Olagoldstx-24292e?style=for-the-badge" alt="GitHub">
  </a>
  <a href="https://youtube.com/@securethecloud-dev">
    <img src="https://img.shields.io/badge/YouTube-SecureTheCloud-FF0000?style=for-the-badge" alt="YouTube">
  </a>
  <img src="https://img.shields.io/badge/Multi--Cloud-AWS%20%7C%20Azure%20%7C%20GCP-4caf50?style=for-the-badge" alt="Multi Cloud">
</p>

---

# 📘 What Is This?

Welcome to the **SecureTheCloud Knowledge Base**, the central home for:

- Cloud Security Architecture theory  
- Zero-Trust implementation guidance  
- IAM / KMS / Networking deep dives  
- Multi-Cloud best practices  
- Binder-style PDF documentation  
- Full hands-on labs for AWS, Azure, and GCP  
- Enterprise-grade architecture diagrams  
- Real-world airline scenario (United Airline Security Program)  

This is your **living textbook**, **lab environment**, and **career accelerator** — all in one.

No boring README. No scattered notes.  
Everything structured. Everything visual. Everything actionable.

---

# 🧭 Living Directory – The SecureTheCloud Learning Map

This is your continuously updated map of the entire knowledge base.

Each module includes:

📘 **Theory**  
🧪 **Lab**  
🎨 **Diagram**  
🎥 **YouTube (when available)**

---

## 🔐 Identity, Access, & Zero-Trust

| # | Topic | Theory | Lab | Diagram | Video |
|---|-------|--------|-----|---------|--------|
| 1 | AWS IAM Identity Center (SSO) | [Theory](theory/aws/02-iam-identity-center/README.md) | [Lab](labs/aws/02-iam-identity-center/) | IAM Federation Flow | (coming) |
| 2 | Zero-Trust Identity Across AWS/Azure/GCP | (coming) | (coming) | ZT Identity Map | (coming) |
| 3 | Multi-Cloud Federation (OIDC & SAML) | (coming) | (coming) | Trust Relationships | (coming) |

---

## 🔒 Encryption, KMS, PKI & HTTPS

| # | Topic | Theory | Lab | Diagram | Video |
|---|-------|--------|-----|---------|--------|
| 1 | How HTTPS Works for Cloud Architects | [Theory](theory/security/https/01_https_for_cloud_architects.md) | [Multi-Cloud Labs](labs/security/https/) | Global TLS Map | (coming) |
| 2 | PKI, Certificates, & mTLS | (coming) | (coming) | PKI Trust Chain | (coming) |
| 3 | AWS KMS, Azure Key Vault, GCP Cloud KMS | (coming) | (coming) | Unified Key Architecture | (coming) |

---

## ☁️ Multi-Cloud Networking & Zero-Trust Routing

| # | Topic | Theory | Lab | Diagram | Video |
|---|-------|--------|-----|---------|--------|
| 1 | Airline Zero-Trust Network (United Airline Project) | (coming) | (coming) | Multi-Cloud Airline Diagram | (coming) |
| 2 | Transit Gateways, VNets, VPC-SC | (coming) | (coming) | Multi-Cloud Routing | (coming) |
| 3 | API Security with API Gateway / APIM / Apigee | (coming) | (coming) | API Trust Boundary | (coming) |

---

## 🛡️ Application, Workload, & Kubernetes Security

| # | Topic | Theory | Lab | Diagram | Video |
|---|-------|--------|-----|---------|--------|
| 1 | CKS Module – Security for EKS/AKS/GKE | (coming) | (coming) | Pod-to-Pod mTLS | (coming) |
| 2 | Admission Control + OPA Gatekeeper | (coming) | (coming) | Policy Flow | (coming) |
| 3 | Artifact Security (ECR, ACR, GCR) | (coming) | (coming) | Supply Chain Flow | (coming) |

---

# 🎨 Master Mermaid Diagram – SecureTheCloud Knowledge Architecture

This diagram gives learners a **single visual map** of the entire knowledge-base.

```mermaid
flowchart TB

    subgraph User["👤 Student / Architect"]
        READ[Browse Knowledge Base]
        WATCH[Watch YouTube Lessons]
        LABS[Run Live Multi-Cloud Labs]
    end

    subgraph Theory["📘 Theory Modules"]
        IDENTITY[Identity & IAM]
        TLS[HTTPS / TLS / PKI]
        NETWORKING[Multi-Cloud Networking]
        K8S[Kubernetes Security]
        COMPLIANCE[Security & Compliance]
    end

    subgraph Labs["🧪 Hands-On Labs"]
        AWS[AWS Labs]
        AZ[Azure Labs]
        GCP[GCP Labs]
        MULTI[Multi-Cloud Labs]
    end

    subgraph Visuals["🎨 Diagrams & Architecture"]
        MMD[Mermaid Diagrams]
        FLOW[Flowcharts & Architecture Maps]
        PDF[Binder-Style PDFs]
    end

    subgraph Content["🎥 YouTube Series"]
        INTRO[Concept Introductions]
        ADV[Deep Dive Sessions]
        DEMO[Live Lab Walkthroughs]
    end

    READ --> THEORYSEL((Select Topic))
    THEORYSEL --> IDENTITY & TLS & NETWORKING & K8S & COMPLIANCE

    WATCH --> Content
    LABS --> Labs

    Theory --> Visuals
    Theory --> Labs
    Labs --> Visuals
