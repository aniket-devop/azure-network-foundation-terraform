variable "subscription_id" {
  description = "Azure subscription ID. Pass it with TF_VAR_subscription_id, never commit it."
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Resource group that holds the Terraform state storage"
  type        = string
  default     = "rg-tfstate"
}

variable "storage_account_name" {
  description = "Storage account for remote state. Must match the backend blocks in the other roots. Globally unique, 3 to 24 lowercase letters or digits."
  type        = string
  default     = "azurecloudtfstate01"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3 to 24 lowercase letters or digits, no hyphens."
  }
}

variable "container_name" {
  description = "Blob container that holds the state files"
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Tags applied to the resources"
  type        = map(string)
  default = {
    project = "azure-network-foundation"
  }
}
