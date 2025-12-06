
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.40.0"
    }
  }
  backend "azurerm" {
        resource_group_name = "rg-pp-demo"
        storage_account_name = "sappdemo001"
        container_name = "pp-tf-state"
        key = "prosjektB.tfstate"
    }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70" 
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
}