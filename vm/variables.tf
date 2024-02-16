
variable "name" {
  description = "The prefix which should be used for all resources in this example"
  default = "poctest"
}


variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "poctest"
}

variable "tags" {
  type = map(any)
  default = {
 
    "Environment"       = "poctest" 
    
  }
}

variable "location" {
  description = "The Azure Region in which all poc resources in this example should be created."
  default = "uksouth"
}
