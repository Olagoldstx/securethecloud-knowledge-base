# 🔐 Module 1 → Day 4 – Encryption & Key Management (KMS & Data Protection)

> _“In the cloud, encryption is the language of trust — keys are the dialects only authorized systems can understand.”_

---

## 🧠 1. Analogy – The Kingdom’s Vault

Imagine your organization as a **kingdom**:
- **Data** = treasure  
- **Vault** = encryption algorithm (AES, RSA)  
- **Keys** = metal keys or digital certificates  
- **Guards** = Key Management Service (KMS) enforcing who opens the vault  
- **Audit Scroll** = logs recording every access attempt  

The job of a **Multi-Cloud Security Architect** is to ensure:
- Every vault is locked properly  
- Every key is protected, rotated, and versioned  
- No one — not even admins — can open it without trace  

---

## 📘 2. Cryptography Fundamentals

| Concept | Description | Analogy |
|----------|--------------|----------|
| **Plaintext** | Original readable data | Treasure in open view |
| **Ciphertext** | Encrypted data | Locked treasure chest |
| **Key** | Secret used to encrypt/decrypt | The unique vault key |
| **Symmetric Encryption** | One key for lock/unlock | Same key for entry/exit |
| **Asymmetric Encryption** | Public key locks, private key unlocks | Mailbox: anyone can drop mail in, only owner opens |
| **Key Lifecycle** | Creation → Storage → Rotation → Destruction | Minting, using, and melting keys |

### Real Cloud Examples
- AWS: **KMS**
- Azure: **Key Vault**
- GCP: **Cloud KMS**

---

## ☁️ 3. Multi-Cloud KMS Mapping

| Feature | AWS KMS | Azure Key Vault | GCP Cloud KMS |
|----------|----------|----------------|----------------|
| **Key Type** | Symmetric & Asymmetric | Symmetric & Asymmetric | Symmetric & Asymmetric |
| **Default Algorithm** | AES-256 | RSA / AES | AES-256 |
| **Rotation Support** | Automatic (1 year) | Manual / Policy-based | Automatic / API-based |
| **Access Control** | IAM + Key Policies | RBAC + Managed Identity | IAM + Resource Policies |
| **Audit Logging** | CloudTrail | Azure Monitor | Cloud Audit Logs |
| **BYOK Support** | Yes | Yes | Yes |
| **HSM Support** | AWS CloudHSM | Managed HSM | Cloud HSM |

---

## 🧩 4. Hands-On Mini-Lab – Create and Use a KMS Key (AWS)

### Objective
Create a customer-managed key (CMK), encrypt data, and verify permissions.

```bash
# 1. Create a new key
aws kms create-key --description "App encryption key" --key-usage ENCRYPT_DECRYPT

# 2. List your keys
aws kms list-keys

# 3. Encrypt a sample file
echo "Cloud Security Architect Training" > secret.txt
aws kms encrypt \
  --key-id <your-key-id> \
  --plaintext fileb://secret.txt \
  --output text \
  --query CiphertextBlob > encrypted.base64

# 4. Decrypt the file
aws kms decrypt \
  --ciphertext-blob fileb://<(base64 --decode encrypted.base64) \
  --output text \
  --query Plaintext | base64 --decode
✅ Expected Outcome:
You can encrypt/decrypt only with the right KMS permissions. Access denied otherwise.

🧱 5. Azure & GCP Equivalents
Azure CLI
bash
Copy code
# Create Key Vault
az keyvault create -n MyVault -g MyResourceGroup -l eastus

# Create a key
az keyvault key create --vault-name MyVault -n appkey --protection software

# Encrypt data
az keyvault key encrypt --name appkey --vault-name MyVault --algorithm RSA-OAEP --value "Hello World"
GCP CLI
bash
Copy code
# Create key ring & key
gcloud kms keyrings create my-ring --location=us
gcloud kms keys create appkey --keyring=my-ring --location=us --purpose=encryption

# Encrypt
echo "Secure GCP Data" | gcloud kms encrypt \
  --plaintext-file=- \
  --ciphertext-file=encrypted.txt \
  --key=appkey \
  --keyring=my-ring \
  --location=us
🧩 6. Architect’s Mindset
Encrypt data in transit (TLS) and at rest (KMS).

Never store secrets in code — use Secret Managers.

Use envelope encryption (application key encrypted by KMS key).

Automate key rotation policies across all clouds.

Centralize audit logs for all cryptographic operations.

ASCII Diagram:

css
Copy code
[App] → [Envelope Encryption] → [KMS Key]
                      │
            ┌─────────┼───────────┐
            ▼         ▼           ▼
        [AWS KMS]  [Azure KV]  [GCP KMS]
🧠 7. Common Pitfalls
Mistake	Impact	Fix
Storing plaintext secrets in code	Credential leaks	Use Secret Manager or environment variables
Hardcoding KMS key IDs	Coupling to region/account	Parameterize keys in IaC
Not rotating keys	Stale encryption	Enable auto-rotation
No audit trails	Blind compliance gaps	Send KMS logs to SIEM

✅ 8. Review Checklist
 Explain symmetric vs asymmetric encryption

 Perform KMS encryption/decryption lab

 Map AWS/Azure/GCP KMS differences

 Enable auto-rotation and audit logging

 Commit notes to GitHub

🧭 9. Next Step
Proceed to Day 5 – Zero Trust Networking and Micro-Segmentation
to learn how to design resilient, identity-aware, policy-driven architectures that protect east-west and north-south cloud traffic.
