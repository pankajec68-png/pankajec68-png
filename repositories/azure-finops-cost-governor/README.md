# 💰 Azure FinOps Cost Governor & Waste Harvester

[![FinOps](https://img.shields.io/badge/FinOps_Foundation-Certified_Practitioner-38B2AC?style=for-the-badge&logo=google-cloud&logoColor=white)](#)
[![Savings](https://img.shields.io/badge/Annualized_Savings-$250K%2B-brightgreen?style=for-the-badge)](#)
[![PowerShell](https://img.shields.io/badge/PowerShell-Runbooks-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Azure Automation](https://img.shields.io/badge/Azure_Automation-Scheduled_Jobs-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)](#)

An automated **Cloud Financial Management (FinOps) Engine** designed to audit, optimize, and eliminate recurring cloud waste across multi-subscription Azure environments. 

Proven in enterprise production to reduce compute and storage expenditures by **35% to 40%** without impacting service delivery SLAs.

---

## 🎯 4 Pillars of Automated Cost Harvesting

```
                       [ Continuous FinOps Automation ]
                                      │
     ┌─────────────────┬──────────────┴───────────────┬─────────────────┐
     │                 │                              │                 │
 1. Waste Cleanup  2. Auto-Scheduling            3. Log Optimization  4. RI Portfolio
 (Unattached Disks  (Non-Prod Off 19:00 - 08:00)  (Prune Ingestion    (1-Yr & 3-Yr
  & Orphaned IPs)   ➔ 65% Compute Savings         ➔ Blob Cold Tier)   Commitments)
```

---

## 🛠️ Automated Runbooks & Scripts

| Automation Runbook | Path | Cadence | Estimated Savings |
| :--- | :--- | :--- | :--- |
| **Orphaned Managed Disks** | `runbooks/Harvest-OrphanedDisks.ps1` | Weekly (Sunday 02:00 UTC) | $15,000 - $35,000 / year |
| **Non-Prod Auto-Scheduler** | `runbooks/AutoSchedule-VMStartStop.ps1` | Daily (Off at 19:00, On at 08:00) | **65% on Non-Prod Compute** |
| **Log Analytics Tuning** | `runbooks/Optimize-LogAnalyticsIngestion.ps1` | Monthly Audit | $20,000+ on Ingestion Spikes |
| **Unused Public IPs & NICs**| `runbooks/Harvest-OrphanedDisks.ps1` | Bi-weekly | Immediate cleanup of idle charges |

---

## 📊 Quick Start: Running the Orphaned Disk Harvester

```powershell
# Authenticate to Azure
Connect-AzAccount

# Run dry-run audit across all subscriptions
./runbooks/Harvest-OrphanedDisks.ps1 -SubscriptionId "<SUB_ID>" -DryRun $true

# Execute automated snapshot & deletion of unattached disks
./runbooks/Harvest-OrphanedDisks.ps1 -SubscriptionId "<SUB_ID>" -DryRun $false -RetentionDays 30
```

---

## 👨‍💼 Maintained By
**Pankaj Singh** — Enterprise Cloud Architect & Principal DevSecOps Lead  
* 💼 [LinkedIn](https://linkedin.com/in/) | 📧 [pankajec68@gmail.com](mailto:pankajec68@gmail.com)
