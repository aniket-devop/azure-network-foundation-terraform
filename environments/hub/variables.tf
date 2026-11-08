variable "subscription_id" {
  description = "Azure subscription ID. Pass it with TF_VAR_subscription_id, do not commit it."
  type        = string
}

variable "prefix" {
  description = "Short project prefix used in resource names, for example ani-cloud."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{2,12}$", var.prefix))
    error_message = "prefix must be 2 to 12 characters: lowercase letters, numbers and hyphens only."
  }
}

variable "location" {
  description = "Azure region for the hub resources."
  type        = string
}

variable "hub_address_space" {
  description = "Address space of the hub VNet."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "firewall_subnet_prefix" {
  description = "CIDR of AzureFirewallSubnet. Must be /26 or larger."
  type        = string
  default     = "10.0.0.0/26"
}

variable "bastion_subnet_prefix" {
  description = "CIDR of AzureBastionSubnet. Must be /26 or larger."
  type        = string
  default     = "10.0.1.0/26"
}

variable "shared_services_subnet_prefix" {
  description = "CIDR of the shared services subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "spoke_address_spaces" {
  description = "Map of spoke name to its address space. Used to build Firewall rules per spoke."
  type        = map(list(string))
  default = {
    dev  = ["10.1.0.0/16"]
    prod = ["10.2.0.0/16"]
  }
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}