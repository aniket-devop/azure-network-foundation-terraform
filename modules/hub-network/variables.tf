variable "resource_group_name" {
  description = "Resource group for the hub network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the hub VNet"
  type        = string
}

variable "hub_address_space" {
  description = "Address space for the hub VNet, e.g. [\"10.0.0.0/16\"]"
  type        = list(string)
}

variable "firewall_subnet_prefix" {
  description = "CIDR for AzureFirewallSubnet (name is fixed by Azure, must be /26 or larger)"
  type        = string
}

variable "bastion_subnet_prefix" {
  description = "CIDR for AzureBastionSubnet (name is fixed by Azure, must be /26 or larger)"
  type        = string
}

variable "shared_services_subnet_prefix" {
  description = "CIDR for the shared services subnet"
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources in this module"
  type        = map(string)
  default     = {}
}
