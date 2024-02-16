terraform {
  backend "azurerm" {
    storage_account_name = "csg10032003449542c0"
    container_name = "heenaaks"
    key = "heenastatevm.tfstate"
    access_key = "D0WMeVN6yC60I/T1QUM0kutdQgpxnjUUkx3oUGWBfJbGvBOYP0XWoEyZYqXpzkQbvggLEE+oI8S7+AStP0uTJg=="
    
  }
  required_version = ">= 0.13"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.56.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
  }
}