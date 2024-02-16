
locals {
  backend_address_pool_name      = "${var.name}-beap"
  frontend_port_name             = "${var.name}-feport"
  frontend_ip_configuration_name = "${var.name}-feip"
  http_setting_name              = "${var.name}-be-htst"
  listener_name                  = "${var.name}-httplstn"
  request_routing_rule_name      = "${var.name}-rqrt"
  redirect_configuration_name    = "${var.name}-rdrcfg"
#
  sku_name = var.waf_enabled ? "WAF_v2" : "Standard_v2"
  sku_tier = var.waf_enabled ? "WAF_v2" : "Standard_v2"
  ssl_certificate_name           = "agw_cert"
}

# Create Public Ip for Appgw

resource "azurerm_public_ip" "ip" {
  name                = "pp-gateway-pip-${var.name}"
  location            = azurerm_resource_group.poctest.location
  resource_group_name = azurerm_resource_group.poctest.name
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = var.tags
  

}


# Create Application gateway as privert with public ip

resource "azurerm_application_gateway" "appgw" {
  name                          = "app-gateway-${var.name}"
  location                      = azurerm_resource_group.poctest.location
  resource_group_name           = azurerm_resource_group.poctest.name
  sku {
    name = local.sku_name
    tier = local.sku_tier
  }

  waf_configuration {
    enabled                  = var.waf_enabled
    #firewall_mode            = coalesce(var.waf_configuration != null ? var.waf_configuration.firewall_mode : null, "Prevention")
    firewall_mode            = coalesce(var.waf_configuration != null ? var.waf_configuration.firewall_mode : null, "Detection")
    rule_set_type            = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_type : null, "OWASP")
    rule_set_version         = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_version : null, "3.2")
    file_upload_limit_mb     = coalesce(var.waf_configuration != null ? var.waf_configuration.file_upload_limit_mb : null, 100)
    max_request_body_size_kb = coalesce(var.waf_configuration != null ? var.waf_configuration.max_request_body_size_kb : null, 128)
   }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 3
  }

  zones = [1, 2, 3]

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.appgw-subnet.id
  }

  frontend_port {
    name = "${local.frontend_port_name}-private"
    port = 80
  }

  frontend_port {
    name = local.frontend_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.ip.id
    #private_ip_address_allocation = "Dynamic"
    #subnet_id = azurerm_subnet.appgw-frontend.id
  }

  frontend_ip_configuration {
    name                          = "${local.frontend_ip_configuration_name}-private"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.4.10"
    subnet_id                     = data.azurerm_subnet.appgw-subnet.id
    private_link_configuration_name = "${local.frontend_ip_configuration_name}-privatelink"
  }

  private_link_configuration {
    name = "${local.frontend_ip_configuration_name}-privatelink"
    ip_configuration {
      name                          = "poctest"
      subnet_id                     = data.azurerm_subnet.appgw-subnet-private-link.id
      private_ip_address_allocation = "Dynamic"
      primary                       = true
    }
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

# set listener to private end point
  http_listener {
    name                           = "${local.listener_name}-private"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}-private"
    frontend_port_name             = "${local.frontend_port_name}-private"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${local.request_routing_rule_name}-private"
    rule_type                  = "Basic"
    priority                   = "1"
    http_listener_name         = "${local.listener_name}-private"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

#
/*   ssl_certificate {
    name     = local.ssl_certificate_name
    data     = filebase64("./server.dev.r10.local.pfx")
    password = "12345"
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = local.ssl_certificate_name
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = "9999"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = "${local.http_setting_name}-443"
  } 

  backend_http_settings {
    name                  = "${local.http_setting_name}-443"
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
  }
 */

  tags = var.tags
  
  depends_on = [
    azurerm_public_ip.ip,
  ]

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      tags,
      backend_address_pool,
      backend_http_settings,
      probe,
      identity,
      request_routing_rule,
      url_path_map,
      frontend_port,
      http_listener,
      redirect_configuration,
      ssl_certificate
    ]
  }
}


