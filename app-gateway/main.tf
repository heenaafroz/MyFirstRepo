resource "azurerm_resource_group" "poctest" {
  name     = "rg-app-gateway-poc-test"
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = false
  }
}

data "azurerm_subnet" "appgw-subnet" {
  name                 = "subnet-app-gateway-poctest"
  virtual_network_name = "vnet-${var.name}"
  resource_group_name  = "rg-vnet-poctest"

    depends_on = [azurerm_virtual_network.poctest ]
}

data "azurerm_subnet" "appgw-subnet-private-link" {
  name                 = "subnet-appgw-privatelink"
  virtual_network_name = "vnet-${var.name}"
  resource_group_name  = "rg-vnet-poctest"
}

/*
data "azurerm_log_analytics_workspace" "workspace" {
  name                 = "log-analytics-poctest"
  resource_group_name  = "rg-log-analytics-poctest"
}
*/