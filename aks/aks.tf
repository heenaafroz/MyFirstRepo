# Create AKS Cluster

locals {
  pocnode = true
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}




resource "azurerm_kubernetes_cluster" "aks-primary" {
  name                    = "aks-${var.name}"
  location                = azurerm_resource_group.poctest.location
  resource_group_name     = azurerm_resource_group.poctest.name
  dns_prefix              = "${var.prefix}"
  private_cluster_enabled = var.aks_private_cluster
    sku_tier                = "Standard"
  azure_policy_enabled    = true

  kubernetes_version      = "1.26.6"
  
  identity {
    type = "SystemAssigned"
  }


//  oms_agent {
//    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace.id
//  }


  linux_profile {
    admin_username  = "ncr_admin"

    ssh_key {
      key_data = tls_private_key.ssh.public_key_openssh
    }
  }

//  monitor_metrics {
//    annotations_allowed = var.metric_annotations_allowlist
//    labels_allowed = var.metric_labels_allowlist
//  }

  default_node_pool {
    name            = "agentpool"
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
    max_pods        = 20
    temporary_name_for_rotation = "vmsizechange" #USed only when you change your VM Size
    zones                   = ["1", "2", "3"]
    type                    = "VirtualMachineScaleSets" #AvailabilitySet  VirtualMachineScaleSets 
    #enable_node_public_ip   = "true"  
    vnet_subnet_id  = data.azurerm_subnet.aks-subnet.id
    node_count      = 2
    #enable_auto_scaling = true
    #min_count           = 1
    #max_count           = 2

    orchestrator_version    = "1.26.6"

  node_labels     = {
    "nodepool" : "defaultnodepool"
  }

  }

  tags = var.tags

  network_profile {
    network_policy     = "azure"
    network_plugin     = "azure"
    # dns_service_ip     = "20.0.0.10"
    # docker_bridge_cidr = "170.10.0.1/16"
    # service_cidr       = "20.0.0.0/16"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.appgw.id
  }

 # depends_on = [
 #   ]

    lifecycle {
      prevent_destroy = false
      ignore_changes = [
        tags,
        ingress_application_gateway,
        service_principal,
        identity,
        network_profile,
        oms_agent
      ]
    }

    depends_on = [ local.pocnode ]
}



resource "azurerm_kubernetes_cluster_node_pool" "pocnode" {
  count                 = local.pocnode ? 1 : 0
  name                  = "mypocapp"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-primary.id
  vnet_subnet_id        = data.azurerm_subnet.aks-subnet.id
  vm_size               = "Standard_B2s" #Standard_E8s_v3
  node_count            = 1
  enable_auto_scaling   = "false"
  max_count             = null   # when enable_auto_scaling is set to `false`
  min_count             = null   # when enable_auto_scaling is set to `false`
  #node_taints           = ["kubernetes.io/node=rabbithq:NoSchedule"]
  node_labels           = {"node" = "rabbithq"}
  orchestrator_version  = "1.26.6"
  os_disk_size_gb       = 100
  os_sku                = "Ubuntu"
  os_type               = "Linux"
  #ultra_ssd_enabled     = "true" # "Availability zone is required for UltraSSD setting."
  zones    = ["1", "2", "3"]
  enable_node_public_ip = false

  tags = {
    Environment = "${var.prefix}"
    Node = "pocnode"
  }

  depends_on = [azurerm_kubernetes_cluster.aks-primary]

  lifecycle {
    prevent_destroy = false
  }
}
