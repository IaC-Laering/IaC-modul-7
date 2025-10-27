
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40"
    }
  }
}

provider "azurerm" {
  features {

    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id                 = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70"
  use_cli                         = true # Bruker pålogging via `az login`
  resource_provider_registrations = "none"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-pp-demo"
  location = "westeurope"
}

# Storage Account for Terraform backend
resource "azurerm_storage_account" "sa" {
  name                     = "sappdemo001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Container for Terraform state files
resource "azurerm_storage_container" "tfstate" {
  name                  = "pp-tf-state"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

# Hent innlogget bruker fra Entra ID
data "azurerm_client_config" "current" {}

# Tilgang til innholdet i containeren
resource "azurerm_role_assignment" "blob_reader" {
    scope = azurerm_storage_account.sa.id
    role_definition_name = "Storage Blob Data Reader"
    principal_id = data.azurerm_client_config.current.object_id
}

# Key Vault (RBAC-enabled)
resource "azurerm_key_vault" "kv" {
  name                       = "kvpp001"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  rbac_authorization_enabled  = true

  # Network rules can be tightened later in exercises
  public_network_access_enabled = true

  tags = {
    purpose = "tf-backend"
  }
}