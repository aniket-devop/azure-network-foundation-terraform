locals {
  env = "dev"
  tags = merge(
    {
      project     = "azure-network-foundation"
      environment = local.env
    },
    var.tags
  )
  hub = data.terraform_remote_state.hub.outputs
}

resource "azurerm_resource_group" "spoke" {
  name     = "rg-${var.prefix}-spoke-${local.env}"
  location = var.location
  tags     = local.tags
}

module "spoke_network" {
  source = "../../modules/spoke-network"

  resource_group_name            = azurerm_resource_group.spoke.name
  location                       = var.location
  spoke_vnet_name                = "vnet-${var.prefix}-spoke-${local.env}"
  spoke_address_space            = var.spoke_address_space
  aks_subnet_prefix              = var.aks_subnet_prefix
  private_endpoint_subnet_prefix = var.private_endpoint_subnet_prefix
  firewall_private_ip            = local.hub.firewall_private_ip
  aks_nsg_name                   = "nsg-${var.prefix}-spoke-${local.env}-aks"
  route_table_name               = "rt-${var.prefix}-spoke-${local.env}"
  tags                           = local.tags
}

module "peering" {
  source = "../../modules/peering"

  spoke_name                = "spoke-${local.env}"
  hub_resource_group_name   = local.hub.hub_resource_group_name
  spoke_resource_group_name = azurerm_resource_group.spoke.name
  hub_vnet_name             = local.hub.hub_vnet_name
  spoke_vnet_name           = module.spoke_network.spoke_vnet_name
  hub_vnet_id               = local.hub.hub_vnet_id
  spoke_vnet_id             = module.spoke_network.spoke_vnet_id
}

module "key_vault" {
  source = "../../modules/key-vault"

  resource_group_name        = azurerm_resource_group.spoke.name
  location                   = var.location
  key_vault_name             = "kv-${var.prefix}-${local.env}-${var.key_vault_name_suffix}"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  private_endpoint_subnet_id = module.spoke_network.private_endpoint_subnet_id
  virtual_network_id         = module.spoke_network.spoke_vnet_id
  tags                       = local.tags
}

module "rbac" {
  source = "../../modules/rbac"

  resource_group_id = azurerm_resource_group.spoke.id

  role_assignments = var.aks_identity_principal_id == "" ? {} : {
    aks-network = {
      principal_id         = var.aks_identity_principal_id
      role_definition_name = "Network Contributor"
    }
  }
}
