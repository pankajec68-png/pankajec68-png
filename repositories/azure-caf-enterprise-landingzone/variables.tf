variable "primary_region" {
  type        = string
  description = "Primary Azure region for Landing Zone infrastructure deployment"
  default     = "eastus"
}

variable "secondary_region" {
  type        = string
  description = "Paired secondary Azure region for BCDR disaster recovery replication"
  default     = "westus"
}

variable "environment" {
  type        = string
  description = "Environment tier (prod, uat, dev)"
  default     = "prod"
}

variable "root_management_group_id" {
  type        = string
  description = "Tenant Root Management Group ID"
}

variable "platform_mgmt_group_name" {
  type        = string
  description = "Display name for Platform Management Group"
  default     = "Platform"
}

variable "workloads_mgmt_group_name" {
  type        = string
  description = "Display name for Workloads Landing Zone Management Group"
  default     = "Landing-Zones"
}

variable "hub_vnet_cidr" {
  type        = list(string)
  description = "Address space for Central HUB Virtual Network"
  default     = ["10.100.0.0/16"]
}

variable "firewall_subnet_cidr" {
  type        = list(string)
  description = "Subnet address range for AzureFirewallSubnet"
  default     = ["10.100.1.0/24"]
}

variable "gateway_subnet_cidr" {
  type        = list(string)
  description = "Subnet address range for GatewaySubnet"
  default     = ["10.100.2.0/24"]
}

variable "spoke_vnet_configurations" {
  type = map(object({
    vnet_name     = string
    address_space = list(string)
    subnets       = map(string)
  }))
  description = "Map of spoke virtual network configurations for Dev, UAT, and Prod tiers"
  default = {
    "dev" = {
      vnet_name     = "vnet-spoke-dev"
      address_space = ["10.101.0.0/16"]
      subnets = {
        "app"  = "10.101.1.0/24"
        "data" = "10.101.2.0/24"
      }
    },
    "uat" = {
      vnet_name     = "vnet-spoke-uat"
      address_space = ["10.102.0.0/16"]
      subnets = {
        "app"  = "10.102.1.0/24"
        "data" = "10.102.2.0/24"
      }
    },
    "prod" = {
      vnet_name     = "vnet-spoke-prod"
      address_space = ["10.103.0.0/16"]
      subnets = {
        "app"  = "10.103.1.0/24"
        "data" = "10.103.2.0/24"
      }
    }
  }
}

variable "subscription_placement" {
  type        = map(string)
  description = "Mapping of Azure Subscription IDs to target Management Groups"
  default     = {}
}

variable "central_log_analytics_id" {
  type        = string
  description = "Resource ID of central Log Analytics workspace"
  default     = ""
}

variable "standard_tags" {
  type        = map(string)
  description = "Standard corporate governance tags enforced across resources"
  default = {
    "ManagedBy"   = "Terraform"
    "Architect"   = "Pankaj Singh"
    "Framework"   = "Azure-CAF-LandingZone"
    "Compliance"  = "CIS-Benchmark"
  }
}
