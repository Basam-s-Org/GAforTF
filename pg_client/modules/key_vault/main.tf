# Specifies that the AzureRM provider is required for this configuration
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Creates an Azure Key Vault resource
resource "azurerm_key_vault" "org_kv" {
  name                        = var.key_vault_name             # Name of the Key Vault
  location                    = var.location                   # Location of the Key Vault
  resource_group_name         = var.resource_group_name        # Name of the resource group
  tenant_id                   = var.tenant_id                  # Tenant ID for the Key Vault
  sku_name                    = "standard"                     # SKU for the Key Vault (standard or premium)
  purge_protection_enabled    = true                           # Enables purge protection to prevent accidental deletion
  enabled_for_disk_encryption = true                           # Enables Key Vault for disk encryption
  enabled_for_deployment      = true                           # Enables Key Vault for deployment
  enabled_for_template_deployment = true                       # Enables Key Vault for template deployment

  # Access policy block to define permissions for a specific tenant and object (user or service principal)
  access_policy {
    tenant_id = var.tenant_id       # Tenant ID for the access policy
    object_id = var.object_id       # Object ID (user or service principal) to grant access

    # List of secret permissions to grant
    secret_permissions = [
      "Get",                        # Permission to get secrets
      "List",                       # Permission to list secrets
      "Set",                        # Permission to set secrets
      "Delete"                      # Permission to delete secrets
    ]
  }
}
