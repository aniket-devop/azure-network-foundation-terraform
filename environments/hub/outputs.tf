output "hub_resource_group_name" {
  description = "Name of the hub resource group."
  value       = azurerm_resource_group.hub.name
}

output "hub_vnet_id" {
  description = "ID of the hub VNet. Used by spokes for peering."
  value       = module.hub_network.hub_vnet_id
}

output "hub_vnet_name" {
  description = "Name of the hub VNet. Used by spokes for peering."
  value       = module.hub_network.hub_vnet_name
}

output "firewall_private_ip" {
  description = "Private IP of the Azure Firewall. Used as next hop in spoke route tables."
  value       = module.firewall.firewall_private_ip
}
