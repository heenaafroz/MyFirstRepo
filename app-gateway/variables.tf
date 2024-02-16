
variable "name" {
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
  description = "The Azure Region in which all my resources in this example should be created."
  default = "uksouth"
}

variable "waf_enabled" {
  description = "Set to true to enable WAF on Application Gateway."
  type        = bool
  default     = true
}

variable "waf_configuration" {
  description = "Configuration block for WAF."
  type = object({
    firewall_mode            = string
    rule_set_type            = string
    rule_set_version         = string
    file_upload_limit_mb     = number
    max_request_body_size_kb = number
  })
  default = null
}
