# Create vNets
resource "azurerm_virtual_network" "poctest" {
  name                = "vnet-${var.name}"
  resource_group_name = azurerm_resource_group.poctest.name
  address_space       = [var.virtual_network_address_prefix]
  location            = azurerm_resource_group.poctest.location


  dynamic "ddos_protection_plan" {
    for_each = azurerm_network_ddos_protection_plan.poctest
    content {
      id     = ddos_protection_plan.value.id
      enable = var.ddos_protection_enable
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_network_ddos_protection_plan.poctest,
    azurerm_resource_group.poctest
  ]
} 
