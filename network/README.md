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
| [azurerm_bastion_host.host](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/bastion_host) | resource |
| [azurerm_network_ddos_protection_plan.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/network_ddos_protection_plan) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/resource_group) | resource |
| [azurerm_route_table.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/route_table) | resource |
| [azurerm_subnet.aks-extand-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet.aks-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet.appgw-privatelink-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet.appgw-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet.bastion-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet.mssql-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet.redis-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet.vm-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet) | resource |
| [azurerm_subnet_route_table_association.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ddos_protection_enable"></a> [ddos\_protection\_enable](#input\_ddos\_protection\_enable) | Enables DDOS protection for the virtual network. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which all primary resources in this example should be created. | `string` | `"uksouth"` | no |
| <a name="input_name"></a> [name](#input\_name) | The prefix which should be used for all resources in this example | `string` | `"prod-primary-uksouth"` | no |
| <a name="input_subnet_address_prefix_aks"></a> [subnet\_address\_prefix\_aks](#input\_subnet\_address\_prefix\_aks) | n/a | `string` | `"10.1.0.0/22"` | no |
| <a name="input_subnet_address_prefix_aks_extand"></a> [subnet\_address\_prefix\_aks\_extand](#input\_subnet\_address\_prefix\_aks\_extand) | n/a | `string` | `"10.1.32.0/19"` | no |
| <a name="input_subnet_address_prefix_appgw"></a> [subnet\_address\_prefix\_appgw](#input\_subnet\_address\_prefix\_appgw) | n/a | `string` | `"10.1.4.0/24"` | no |
| <a name="input_subnet_address_prefix_appgw_privatelink"></a> [subnet\_address\_prefix\_appgw\_privatelink](#input\_subnet\_address\_prefix\_appgw\_privatelink) | n/a | `string` | `"10.1.8.0/24"` | no |
| <a name="input_subnet_address_prefix_bastion"></a> [subnet\_address\_prefix\_bastion](#input\_subnet\_address\_prefix\_bastion) | n/a | `string` | `"10.1.6.0/27"` | no |
| <a name="input_subnet_address_prefix_mssql"></a> [subnet\_address\_prefix\_mssql](#input\_subnet\_address\_prefix\_mssql) | n/a | `string` | `"10.1.5.0/24"` | no |
| <a name="input_subnet_address_prefix_redis"></a> [subnet\_address\_prefix\_redis](#input\_subnet\_address\_prefix\_redis) | n/a | `string` | `"10.1.9.0/24"` | no |
| <a name="input_subnet_address_prefix_vm"></a> [subnet\_address\_prefix\_vm](#input\_subnet\_address\_prefix\_vm) | n/a | `string` | `"10.1.7.0/24"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "Environment": "Production",<br>  "Notice": "Production-Dont-Remove",<br>  "OperationsTeam": "ncr-devops",<br>  "Region": "Uk-South",<br>  "Retailer": "Asda",<br>  "Workspace": "Primary"<br>}</pre> | no |
| <a name="input_virtual_network_address_prefix"></a> [virtual\_network\_address\_prefix](#input\_virtual\_network\_address\_prefix) | VNET address prefix | `string` | `"10.1.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->