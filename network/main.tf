

resource "azurerm_resource_group" "poctest" {
  name     = "rg-vnet-poctest"
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = false
  }
}

