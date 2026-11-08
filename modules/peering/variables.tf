variable "spoke_name" {
  description = "Short name of the spoke, for example spoke-dev. Used in the peering names."
  type        = string
}

variable "hub_resource_group_name" {
  description = "Resource group of the hub VNet"
  type        = string
}

variable "spoke_resource_group_name" {
  description = "Resource group of the spoke VNet"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the hub VNet"
  type        = string
}

variable "spoke_vnet_name" {
  description = "Name of the spoke VNet"
  type        = string
}

variable "hub_vnet_id" {
  description = "ID of the hub VNet"
  type        = string
}

variable "spoke_vnet_id" {
  description = "ID of the spoke VNet"
  type        = string
}
