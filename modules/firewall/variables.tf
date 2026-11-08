variable "resource_group_name" {
  description = "Resource group where the firewall, policy and public IP are created."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "firewall_name" {
  description = "Name of the Azure Firewall. Public IP and policy names are derived from it."
  type        = string
}

variable "firewall_subnet_id" {
  description = "ID of AzureFirewallSubnet in the hub VNet."
  type        = string
}

variable "sku_tier" {
  description = "Azure Firewall tier. Standard or Premium. Basic is not supported by this module yet."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be Standard or Premium."
  }
}

variable "spoke_address_spaces" {
  description = "Map of spoke name to its address space. One rule collection is created per spoke."
  type        = map(list(string))
}

variable "tags" {
  description = "Tags applied to all resources in this module."
  type        = map(string)
  default     = {}
}
