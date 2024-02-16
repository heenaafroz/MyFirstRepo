# Create Tables
resource "azurerm_route_table" "poctest" {
  name                          = "routetable"
  location                      = azurerm_resource_group.poctest.location
  resource_group_name           = azurerm_resource_group.poctest.name
  disable_bgp_route_propagation = false

  depends_on = [
    azurerm_subnet.mssql-subnet,
  ]
}

# Associate route tables with subnets
resource "azurerm_subnet_route_table_association" "poctest" {
  subnet_id      = azurerm_subnet.mssql-subnet.id
  route_table_id = azurerm_route_table.poctest.id
}