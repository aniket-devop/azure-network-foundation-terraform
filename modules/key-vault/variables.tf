variable "resource_group_name" {
  description = "Resource group for the Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "key_vault_name" {
  description = "Key Vault name. Must be globally unique, 3 to 24 characters."
  type        = string

  validation {
    condition     = length(var.key_vault_name) >= 3 && length(var.key_vault_name) <= 24
    error_message = "key_vault_name must be 3 to 24 characters."
  }
}

variable "tenant_id" {
  description = "Entra ID tenant ID"
  type        = string
}

variable "allowed_subnet_ids" {
  description = "Subnets allowed through the Key Vault firewall. Needs the Microsoft.KeyVault service endpoint on each subnet. Leave empty when only a private endpoint is used."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to all resources in this module"
  type        = map(string)
  default     = {}
}

variable "private_endpoint_subnet_id" {
  description = "ID of the subnet where the Key Vault private endpoint is placed"
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the VNet that gets linked to the Key Vault private DNS zone"
  type        = string
}
