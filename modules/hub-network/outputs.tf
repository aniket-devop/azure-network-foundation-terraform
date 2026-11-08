output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.hub.name
}

output "firewall_subnet_id" {
  value = azurerm_subnet.firewall.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}

output "shared_services_subnet_id" {
  value = azurerm_subnet.shared_services.id
}
