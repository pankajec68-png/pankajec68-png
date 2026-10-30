output "hub_vnet_id" {
  description = "The Resource ID of the Central HUB Virtual Network"
  value       = module.hub_spoke_network.hub_vnet_id
}

output "azure_firewall_private_ip" {
  description = "Private IP address of the Central Azure Firewall for UDR next-hop routing"
  value       = module.hub_spoke_network.azure_firewall_private_ip
}

output "platform_management_group_id" {
  description = "Resource ID of the Platform Management Group"
  value       = module.management_groups.platform_group_id
}

output "workloads_management_group_id" {
  description = "Resource ID of the Workloads Landing Zone Management Group"
  value       = module.management_groups.workloads_group_id
}

output "spoke_vnet_peering_status" {
  description = "Status of bidirectional peering between Hub and Spoke VNets"
  value       = module.hub_spoke_network.peering_status
}
