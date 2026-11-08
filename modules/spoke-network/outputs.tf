output "spoke_vnet_id" {
  value = azurerm_virtual_network.spoke.id
}

output "spoke_vnet_name" {
  value = azurerm_virtual_network.spoke.name
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "aks_nsg_id" {
  value = azurerm_network_security_group.aks.id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private_endpoints.id
}

output "route_table_id" {
  value = azurerm_route_table.spoke.id
}
