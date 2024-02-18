terraform {
 
  required_version = ">= 0.14"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = latest
    }
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
  }
}

module aks {
    source ="./aks"
  
}

module app-gateway {
    source ="./app-gateway"
  }

module network {
    source ="./network"
}

module vm {
source ="./vm"
}
