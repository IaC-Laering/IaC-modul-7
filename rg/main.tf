
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.40.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70" 
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
  }
}
