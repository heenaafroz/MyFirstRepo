

resource "azurerm_resource_group" "poctest" {
  name     = "rg-vm-poctest"
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = false
  }
}

data "azurerm_subnet" "vm-subnet" {
  name                 = "subnet-vm-poctest"
  virtual_network_name = "vnet-${var.name}"
  resource_group_name  = "rg-vnet-poctest"

//depends_on = [ azurerm_virtual_network.poctest ]
}

