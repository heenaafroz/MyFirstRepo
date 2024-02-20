
variable "name" {
  description = "The prefix which should be used for all resources in this example"
  default = "poctest"
}

variable "tags" {
  type = map(any)
  default = {
    "Environment"  = "ASW - POCtest" 
  }
}

variable "location" {
  description = "The Azure Region in which all primary resources in this example should be created."
  default = "uksouth"
}

variable "virtual_network_address_prefix" {
  description = "VNET address prefix"
  default     = "10.1.0.0/16"
}

variable "subnet_address_prefix_aks" {
  default = "10.1.0.0/22"
}

variable "subnet_address_prefix_aks_extand" {
  default = "10.1.32.0/19"
}

variable "subnet_address_prefix_appgw" {
  default = "10.1.4.0/24"
}

variable "subnet_address_prefix_mssql" {
  default = "10.1.5.0/24"
}

variable "subnet_address_prefix_bastion" {
  default = "10.1.6.0/27"
}

variable "subnet_address_prefix_vm" {
  default = "10.1.7.0/24"
}

variable "subnet_address_prefix_appgw_privatelink" {
  default = "10.1.8.0/24"
}

variable "subnet_address_prefix_redis" {
  default = "10.1.9.0/24"
}

variable "ddos_protection_enable" {
  description = "Enables DDOS protection for the virtual network."
  type    = bool
  default = true
  sensitive = false
}
