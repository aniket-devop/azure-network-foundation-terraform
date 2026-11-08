resource "azurerm_resource_group" "hub" {
  name     = "rg-${var.prefix}-hub"
  location = var.location
  tags     = var.tags
}

module "hub_network" {
  source = "../../modules/hub-network"

  resource_group_name           = azurerm_resource_group.hub.name
  location                      = var.location
  hub_vnet_name                 = "vnet-${var.prefix}-hub"
  hub_address_space             = var.hub_address_space
  firewall_subnet_prefix        = var.firewall_subnet_prefix
  bastion_subnet_prefix         = var.bastion_subnet_prefix
  shared_services_subnet_prefix = var.shared_services_subnet_prefix
  tags                          = var.tags
}