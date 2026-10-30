# 🚀 Enterprise DevSecOps Pipeline Accelerator

[![Azure DevOps](https://img.shields.io/badge/Azure_DevOps-Enterprise_Pipelines-0078D7?style=for-the-badge&logo=azure-devops&logoColor=white)](https://azure.microsoft.com/services/devops/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/features/actions)
[![TruffleHog](https://img.shields.io/badge/TruffleHog-Secret_Scanning-FF6B6B?style=for-the-badge)](https://trufflesecurity.com/)
[![Infracost](https://img.shields.io/badge/Infracost-FinOps_Shift--Left-4B5563?style=for-the-badge)](https://www.infracost.io/)

A battle-tested **DevSecOps Pipeline Framework** utilizing reusable YAML templates, **Trunk-Based Branching policies**, shift-left security scanning, FinOps budget guardrails, and automated rollback capabilities for enterprise cloud infrastructure.

---

## 📐 Multi-Stage Pipeline Architecture

```
Developer PR
    │
    ▼
[ Branch Policy Gates ] ──► 1. TFLint & Format Check
                          ──► 2. TruffleHog Secrets Scanner
                          ──► 3. Checkov CIS Security Benchmark
                          ──► 4. Infracost FinOps Delta Check
                          ──► 5. Mandatory Code Owners Review (2+ Approvers)
    │
    ▼
Merge to Main (Trunk)
    │
    ├─► Stage 1: Validate & Test (Reusable YAML Template)
    ├─► Stage 2: Build & Package Artifacts
    ├─► Stage 3: Staged Deployment (Dev ➔ UAT)
    ├─► Stage 4: Manual Approval Gate (Production Sign-off)
    ├─► Stage 5: Production Apply & Telemetry Verification
    └─► Stage 6: Automated Rollback on Smoke Test Failure
```

---

## 🛠️ Reusable Pipeline Templates

| Template | Path | Purpose |
| :--- | :--- | :--- |
| **Validate & Test** | `templates/validate-test.yml` | Validates Terraform formatting, performs static analysis with `tflint`. |
| **Security Scanning** | `templates/security-scan.yml` | Runs `TruffleHog` to catch committed secrets; executes `Checkov` against CIS benchmarks. |
| **FinOps Budget** | `templates/infracost-check.yml` | Evaluates cloud cost deltas and comments projections directly on PRs. |
| **Deploy & Apply** | `templates/deploy-apply.yml` | Deploys staged environments with manual approvals and smoke tests. |
| **Automated Rollback** | `templates/rollback.yml` | Executes automated fallback if health checks fail post-deployment. |

---

## 🛡️ Branching Strategy & Branch Policies

* **Trunk-Based Model**: Developers commit to short-lived feature branches (`feat/*`, `fix/*`).
* **Branch Policy Enforcements on `main`**:
  * ❌ Direct commits blocked.
  * ❌ Branch deletion disabled.
  * ✅ Mandatory Pull Requests with minimum 2 reviewers.
  * ✅ Designated **Code Owners** must sign off on architecture/security directories.
  * ✅ All CI checks (linting, secret scan, costing) must pass before merge.

---

## 👨‍💼 Maintained By
**Pankaj Singh** — Enterprise Cloud Architect & Principal DevSecOps Lead  
* 💼 [LinkedIn](https://linkedin.com/in/) | 📧 [pankajec68@gmail.com](mailto:pankajec68@gmail.com)
