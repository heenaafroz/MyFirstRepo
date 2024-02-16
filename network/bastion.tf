
# Create Bastion Host 

resource "azurerm_public_ip" "pip" {
  name                = "bastion-ip-${var.name}"
  location            = azurerm_resource_group.poctest.location
  resource_group_name = azurerm_resource_group.poctest.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
  
  lifecycle {
    ignore_changes = [
      allocation_method,
      sku,
      zones,
    ]
  }
}

resource "azurerm_bastion_host" "host" {
  name                = "bastion-${var.name}"
  location            = azurerm_resource_group.poctest.location
  resource_group_name = azurerm_resource_group.poctest.name

  ip_connect_enabled = true
  copy_paste_enabled = true
  file_copy_enabled  = true    # is only supported when `sku` is `Standard`
  sku = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  tags = var.tags
  
depends_on          = [
    azurerm_virtual_network.poctest,
    azurerm_subnet.bastion-subnet,
]

}