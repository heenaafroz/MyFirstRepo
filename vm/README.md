<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.56.0 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dev_test_global_vm_shutdown_schedule.schedule-linux-vm-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_dev_test_global_vm_shutdown_schedule.schedule-windows-vm-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_dev_test_global_vm_shutdown_schedule.schedule-windows-vm-support-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/dev_test_global_vm_shutdown_schedule) | resource |
| [azurerm_linux_virtual_machine.linux-vm-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.linux-nic-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface.windows-nic-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface.windows-nic-support-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/network_interface) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/resource_group) | resource |
| [azurerm_virtual_machine_extension.BGInfo](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.bootstrap-linux-vm-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.bootstrap-windows-vm-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.bootstrap-windows-vm-support-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.support-BGInfo](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.windows-vm-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/windows_virtual_machine) | resource |
| [azurerm_windows_virtual_machine.windows-vm-support-primary](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/resources/windows_virtual_machine) | resource |
| [azurerm_subnet.vm-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.56.0/docs/data-sources/subnet) | data source |
| [template_file.file-windows-vm-primary](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.file-windows-vm-support-primary](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which all primary resources in this example should be created. | `string` | `"uksouth"` | no |
| <a name="input_name"></a> [name](#input\_name) | The prefix which should be used for all resources in this example | `string` | `"prod-primary-uksouth"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix which should be used for all resources in this example | `string` | `"prod-pri"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "Environment": "Production",<br>  "Notice": "Production-Dont-Remove",<br>  "OperationsTeam": "ncr-devops",<br>  "Region": "Uk-South",<br>  "Retailer": "Asda",<br>  "Workspace": "Primary"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->