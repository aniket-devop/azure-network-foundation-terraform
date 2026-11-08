output "resource_group_name" {
  description = "Resource group of the state storage"
  value       = azurerm_resource_group.state.name
}

output "storage_account_name" {
  description = "Storage account of the state storage"
  value       = azurerm_storage_account.state.name
}

output "container_name" {
  description = "Blob container for the state files"
  value       = azurerm_storage_container.state.name
}
