variable "subscription_id" {
  description = "Azure subscription ID. Pass it with TF_VAR_subscription_id, never commit it."
  type        = string
}

variable "prefix" {
  description = "Short prefix used in resource names"
  type        = string
  default     = "ani-cloud"

  validation {
    condition     = can(regex("^[a-z0-9-]{2,12}$", var.prefix))
    error_message = "prefix must be 2 to 12 characters: lowercase letters, digits and hyphens."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "spoke_address_space" {
  description = "Address space of the prod spoke VNet"
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "aks_subnet_prefix" {
  description = "Address prefix of snet-aks"
  type        = string
  default     = "10.2.0.0/22"
}

variable "private_endpoint_subnet_prefix" {
  description = "Address prefix of snet-private-endpoints"
  type        = string
  default     = "10.2.4.0/24"
}

variable "key_vault_name_suffix" {
  description = "Suffix that makes the Key Vault name globally unique. 3 to 6 lowercase letters or digits."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,6}$", var.key_vault_name_suffix))
    error_message = "key_vault_name_suffix must be 3 to 6 lowercase letters or digits."
  }
}

variable "aks_identity_principal_id" {
  description = "Principal ID of the AKS identity. Leave empty until the cluster exists."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Extra tags merged with the default tags"
  type        = map(string)
  default     = {}
}
