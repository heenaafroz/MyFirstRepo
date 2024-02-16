<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.appgw](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/application_gateway) | resource |
| [azurerm_monitor_diagnostic_setting.log_analytics_diagnostic_appgw_primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/resource_group) | resource |
| [azurerm_log_analytics_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_subnet.appgw-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.appgw-subnet-private-link](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which all primary resources in this example should be created. | `string` | `"uksouth"` | no |
| <a name="input_name"></a> [name](#input\_name) | The prefix which should be used for all resources in this example | `string` | `"prod-primary-uksouth"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "Environment": "Production",<br>  "Notice": "Production-Dont-Remove",<br>  "OperationsTeam": "ncr-devops",<br>  "Region": "Uk-South",<br>  "Retailer": "Asda",<br>  "Workspace": "Primary"<br>}</pre> | no |
| <a name="input_waf_configuration"></a> [waf\_configuration](#input\_waf\_configuration) | Configuration block for WAF. | <pre>object({<br>    firewall_mode            = string<br>    rule_set_type            = string<br>    rule_set_version         = string<br>    file_upload_limit_mb     = number<br>    max_request_body_size_kb = number<br>  })</pre> | `null` | no |
| <a name="input_waf_enabled"></a> [waf\_enabled](#input\_waf\_enabled) | Set to true to enable WAF on Application Gateway. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->