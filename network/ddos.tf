# Create Ddos 
resource "azurerm_network_ddos_protection_plan" "poctest" {
  count               = var.ddos_protection_enable ? 1 : 0
  
  name                = var.ddos_protection_enable ? "ddos-${var.name}" : null
  location            = azurerm_resource_group.poctest.location
  resource_group_name = azurerm_resource_group.poctest.name
  tags = var.tags

  depends_on = [
    azurerm_resource_group.poctest
  ]
}