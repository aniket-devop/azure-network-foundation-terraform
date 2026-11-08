variable "resource_group_name" {
  description = "Resource group where the Bastion host and its public IP are created."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "bastion_name" {
  description = "Name of the Bastion host. The public IP name is derived from it."
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID of AzureBastionSubnet in the hub VNet."
  type        = string
}

variable "sku" {
  description = "Bastion SKU. Basic or Standard. Basic costs less and is enough for portal based SSH and RDP."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "sku must be Basic or Standard."
  }
}

variable "tags" {
  description = "Tags applied to all resources in this module."
  type        = map(string)
  default     = {}
}
