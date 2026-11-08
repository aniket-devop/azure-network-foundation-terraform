variable "resource_group_name" {
  description = "Resource group for the spoke network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "spoke_vnet_name" {
  description = "Name of the spoke VNet"
  type        = string
}

variable "spoke_address_space" {
  description = "Address space for the spoke VNet, e.g. [\"10.1.0.0/16\"]"
  type        = list(string)
}

variable "aks_subnet_prefix" {
  description = "CIDR for the AKS subnet"
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources in this module"
  type        = map(string)
  default     = {}
}

variable "private_endpoint_subnet_prefix" {
  description = "CIDR for the private endpoint subnet"
  type        = string
}

variable "firewall_private_ip" {
  description = "Private IP of the hub Azure Firewall. Used as next hop in the route table."
  type        = string
}

variable "aks_nsg_name" {
  description = "Name of the NSG attached to the AKS subnet"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table that sends spoke egress to the firewall"
  type        = string
}
