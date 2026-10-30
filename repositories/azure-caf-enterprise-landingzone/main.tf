terraform {
  required_version = ">= 1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
  }

  backend "azurerm" {
    # Populated dynamically via -backend-config or CI/CD pipelines
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

# 1. Management Groups Hierarchy Module
module "management_groups" {
  source = "./modules/management_groups"

  root_parent_id          = var.root_management_group_id
  platform_mgmt_group     = var.platform_mgmt_group_name
  workloads_mgmt_group    = var.workloads_mgmt_group_name
  subscription_mapping    = var.subscription_placement
}

# 2. Hub-and-Spoke Networking Module
module "hub_spoke_network" {
  source = "./modules/hub_spoke_network"

  location                = var.primary_region
  hub_resource_group_name = "rg-hub-connectivity-${var.environment}"
  hub_vnet_cidr           = var.hub_vnet_cidr
  firewall_subnet_cidr    = var.firewall_subnet_cidr
  gateway_subnet_cidr     = var.gateway_subnet_cidr
  spoke_vnets             = var.spoke_vnet_configurations

  depends_on = [module.management_groups]
}

# 3. Governance & Azure Policy Module
module "governance_policies" {
  source = "./modules/governance_policies"

  management_group_id     = module.management_groups.root_group_id
  enforce_cis_benchmark   = true
  log_analytics_id        = var.central_log_analytics_id

  tags = var.standard_tags
}
