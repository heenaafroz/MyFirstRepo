//data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "poctest" {
  name     = "rg-aks-testpoc"
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = false
  } 
}

data "azurerm_subnet" "aks-subnet" {
 name                 = "subnet-aks-poctest"
 virtual_network_name = "vnet-poctest"
 resource_group_name  = "rg-vnet-poctest"
}

data "azurerm_application_gateway" "appgw"{
  name =  "app-gateway-poctest"
  resource_group_name = "rg-app-gateway-poc-test"
}

data "azurerm_virtual_network" "poctest" {
  name                 = "vnet-poctest"
  resource_group_name  = "rg-vnet-poctest"
}

