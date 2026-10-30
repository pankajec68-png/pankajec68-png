# 🛡️ Azure Zero-Trust Cloud Guardrails & Policy Engine

[![Zero Trust](https://img.shields.io/badge/Security-Zero_Trust_Architecture-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)](#)
[![Azure Policy](https://img.shields.io/badge/Azure_Policy-Custom_Initiatives-0089D6?style=for-the-badge)](#)
[![CIS Benchmark](https://img.shields.io/badge/Compliance-CIS_Azure_Benchmark-107C41?style=for-the-badge)](#)
[![Entra PIM](https://img.shields.io/badge/Identity-Entra_ID_PIM-24292E?style=for-the-badge)](#)

A centralized **Zero-Trust Security Governance Repository** containing production-tested Azure Policy definitions, CIS benchmark initiatives, and Microsoft Entra ID Privileged Identity Management (PIM) approval blueprints.

---

## 🔒 Defense-in-Depth Architecture

```
  ┌────────────────────────────────────────────────────────────────────────┐
  │ 1. Identity Level   : Entra ID PIM, Just-In-Time Access, Conditional   │
  │                       Access Policies, Mandatory Phishing-Resistant MFA│
  ├────────────────────────────────────────────────────────────────────────┤
  │ 2. Network Level    : Deny Public PaaS Endpoints, Enforce Private Link,│
  │                       Azure Firewall Layer 7 Application Rules         │
  ├────────────────────────────────────────────────────────────────────────┤
  │ 3. Compute Level    : CIS-Hardened OS Baselines, Automated Patching,   │
  │                       Customer-Managed Key (CMEK) Disk Encryption      │
  ├────────────────────────────────────────────────────────────────────────┤
  │ 4. Governance Level : Continuous Compliance Auditing via Azure Policy  │
  │                       Initiatives with Automated Remediation Tasks     │
  └────────────────────────────────────────────────────────────────────────┘
```

---

## 📜 Custom Azure Policy Guardrails

| Policy Definition | Path | Effect | Purpose |
| :--- | :--- | :--- | :--- |
| **Deny Public PaaS Endpoints** | `policies/deny_public_endpoints.json` | `Deny` | Blocks Storage Accounts, SQL, and Key Vaults created without Private Endpoints. |
| **Enforce CMEK Encryption** | `policies/enforce_cmek_encryption.json` | `Deny` | Requires all managed disks to be encrypted with Customer-Managed Keys (CMK). |
| **Enforce TLS 1.3** | `policies/require_secure_tls.json` | `Modify` | Automatically elevates API endpoints and storage ingress to TLS 1.3. |
| **Enterprise Security Initiative** | `initiatives/enterprise_security_baseline.json` | `AuditIfNotExists` | Grouped initiative auditing adherence to CIS Benchmark v2.0. |

---

## 🔑 Microsoft Entra PIM Just-In-Time Blueprints

* Located in `pim/pim_role_assignment_workflow.json`:
  * Standing Administrator privileges = **0**.
  * Max activation duration = **4 hours**.
  * Requires mandatory business justification and ticket number.
  * Approval required from Security Operations Lead.
  * MFA re-authentication enforced upon activation.

---

## 👨‍💼 Maintained By
**Pankaj Singh** — Enterprise Cloud Architect & Principal DevSecOps Lead  
* 💼 [LinkedIn](https://linkedin.com/in/) | 📧 [pankajec68@gmail.com](mailto:pankajec68@gmail.com)
