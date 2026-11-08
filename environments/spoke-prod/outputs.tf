output "spoke_resource_group_name" {
  description = "Name of the prod spoke resource group"
  value       = azurerm_resource_group.spoke.name
}

output "spoke_vnet_id" {
  description = "ID of the prod spoke VNet"
  value       = module.spoke_network.spoke_vnet_id
}

output "aks_subnet_id" {
  description = "ID of snet-aks"
  value       = module.spoke_network.aks_subnet_id
}

output "private_endpoint_subnet_id" {
  description = "ID of snet-private-endpoints"
  value       = module.spoke_network.private_endpoint_subnet_id
}

output "key_vault_id" {
  description = "ID of the prod Key Vault"
  value       = module.key_vault.key_vault_id
}

output "key_vault_uri" {
  description = "URI of the prod Key Vault"
  value       = module.key_vault.key_vault_uri
}
