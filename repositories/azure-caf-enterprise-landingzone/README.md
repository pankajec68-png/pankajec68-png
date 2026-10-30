# 🏛️ Azure CAF Enterprise Landing Zone

[![Terraform](https://img.shields.io/badge/Terraform-1.7+-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Microsoft_Azure-CAF_Foundation-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Drift Detection](https://img.shields.io/badge/Drift_Detection-Passing-brightgreen?style=for-the-badge&logo=github-actions&logoColor=white)](#)

Production-ready Terraform implementation of the **Microsoft Azure Cloud Adoption Framework (CAF) Enterprise-Scale Landing Zone**. Designed for scalable, multi-tenant enterprise environments supporting **100+ business workloads** across Dev, UAT, and Production.

---

## 📐 Architecture Topology

```
                         Tenant Root Group (Microsoft Entra ID)
                                          │
       ┌──────────────────┬───────────────┴───────────────┬──────────────────┐
       │                  │                               │                  │
  Platform MG        Landing Zones MG                 Sandbox MG      Decommissioned MG
       │                  │                               │                  │
 ┌─────┼─────┐      ┌─────┼─────┐                         └─ Isolated R&D    └─ Read-Only Lock
 │     │     │      │     │     │
Conn  Ident Mgmt   Dev   UAT   Prod
```

### Key Engineering Features
* **Management Group Hierarchy**: Strict segregation of Platform (Connectivity, Identity, Management) vs. Application Landing Zones (`Dev`, `UAT`, `Prod`).
* **Hub-and-Spoke Networking**:
  * Hub VNet with centralized Azure Firewall, VPN/ExpressRoute Gateways, and Azure Bastion.
  * Spoke VNets peered with Gateway Transit enabled.
  * UDR route tables forcing `0.0.0.0/0` traffic through Azure Firewall for centralized egress inspection.
* **Zero-Trust Identity**: Microsoft Entra ID integration with Privileged Identity Management (PIM) and least-privilege RBAC assignments.
* **Policy Guardrails**: CIS Azure Benchmark initiatives assigned at Management Group root with automated compliance reporting.
* **Remote State**: Georedundant encrypted Azure Blob Storage with state lease locking.

---

## 🚀 Quick Start

### Prerequisites
* Terraform `>= 1.7.0`
* Azure CLI `>= 2.50.0`
* Azure Subscription with `Owner` or `User Access Administrator` on the Root Management Group.

### Deployment

```bash
# 1. Clone repository
git clone https://github.com/pankajec68-png/azure-caf-enterprise-landingzone.git
cd azure-caf-enterprise-landingzone

# 2. Authenticate to Azure
az login
az account set --subscription "<MANAGEMENT_SUBSCRIPTION_ID>"

# 3. Initialize Terraform with remote backend
terraform init \
  -backend-config="resource_group_name=rg-terraform-state" \
  -backend-config="storage_account_name=sttfstatecafprod" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=landingzone.terraform.tfstate"

# 4. Preview planned infrastructure
terraform plan -out=tfplan

# 5. Apply architecture baseline
terraform apply tfplan
```

---

## 📦 Modular Structure

```
├── main.tf                       # Root execution coordinator
├── variables.tf                  # Configuration inputs & CIDR blocks
├── outputs.tf                    # Resource IDs and connectivity outputs
├── terraform.tfvars.example      # Sample production parameters
├── modules/
│   ├── management_groups/        # Hierarchy & Subscription placement
│   ├── hub_spoke_network/        # Hub VNet, Firewall, Peering & UDRs
│   ├── private_dns/              # Centralized privatelink DNS zones
│   └── governance_policies/      # Azure Policy Initiatives & RBAC
└── .github/
    └── workflows/
        └── drift-detection.yml   # Nightly scheduled drift audit
```

---

## 🛡️ Security & Drift Governance
This repository includes a scheduled **Nightly Drift Detection** pipeline:
```bash
terraform plan -detailed-exitcode -no-color
```
Any out-of-band manual modification made in Azure Portal triggers an automatic P1 alert in the engineering Slack/Teams channel.

---

## 👨‍💼 Maintained By
**Pankaj Singh** — Enterprise Cloud Architect & Principal DevSecOps Lead  
* 💼 [LinkedIn](https://linkedin.com/in/) | 📧 [pankajec68@gmail.com](mailto:pankajec68@gmail.com)
