
# Create subnets
resource "azurerm_subnet" "mssql-subnet" {
  name                 = "subnet-mssql-poctest"
  resource_group_name  = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes      = [var.subnet_address_prefix_mssql]

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_subnet" "aks-subnet" {
  name                 = "subnet-aks-poctest"
  resource_group_name  = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes      = [var.subnet_address_prefix_aks]

  depends_on          = [azurerm_virtual_network.poctest]
}

resource "azurerm_subnet" "aks-extand-subnet" {
  name                 = "subnet-aks-extand-poctest"
  resource_group_name  = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes      = [var.subnet_address_prefix_aks_extand]

  depends_on          = [azurerm_virtual_network.poctest]
}


resource "azurerm_subnet" "appgw-subnet" {
  name                 = "subnet-app-gateway-poctest"
  resource_group_name  = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes      = [var.subnet_address_prefix_appgw]

  depends_on          = [azurerm_virtual_network.poctest]
}

#https://learn.microsoft.com/en-us/azure/private-link/disable-private-link-service-network-policy

resource "azurerm_subnet" "appgw-privatelink-subnet" {
  name                 = "subnet-appgw-privatelink"
  resource_group_name  = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes      = [var.subnet_address_prefix_appgw_privatelink]
  private_link_service_network_policies_enabled = false

  depends_on          = [azurerm_virtual_network.poctest]
}

resource "azurerm_subnet" "redis-subnet" {
  name                 = "subnet-redis-poctest"
  resource_group_name  = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes      = [var.subnet_address_prefix_redis]

  depends_on          = [azurerm_virtual_network.poctest]
}

resource "azurerm_subnet" "vm-subnet" {
  name                 = "subnet-vm-poctest"
  resource_group_name = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes     = [var.subnet_address_prefix_vm]
}

resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.poctest.name
  virtual_network_name = azurerm_virtual_network.poctest.name
  address_prefixes     = [var.subnet_address_prefix_bastion]
}