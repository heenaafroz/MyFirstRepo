terraform {
   backend "azurerm" {
    storage_account_name = "heenastore"
    container_name = "heenaaks"
    key = "vnet.tfstate"
    access_key = "X9pNzDvqwIlnKYh3/HaKZSeL1yUihU5H1qszjDmWaj3qdld8dEoCBp8zxqwSaygtJY9V5dqSVf0n+ASt7S0DTg=="
    
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
