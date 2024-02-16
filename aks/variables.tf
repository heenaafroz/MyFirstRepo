 variable "tags" {
  type = map(any)
  default = {
    "Environment"       = "POC-Test" 
  }
}


variable "name" {
  description = "The prefix which should be used for all resources in this example"
  default = "poc-test"
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "poc-test"
}


variable "aks_private_cluster" {
  description = "enable private aks cluster"
  default = "false"
}

variable "location" {
  description = "The Azure Region in which all primary resources in this example should be created."
  default = "uksouth"
}

/*
variable "metric_labels_allowlist" {
  default = null
}

variable "metric_annotations_allowlist" {
  default = null
}
*/