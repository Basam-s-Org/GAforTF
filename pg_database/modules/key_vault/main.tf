# Retrieve the current Azure client configuration
data "azurerm_client_config" "current" {}

# Create an Azure Key Vault resource
resource "azurerm_key_vault" "key_vault" {
  name                        = var.db_secret_kv       # Key Vault name
  location                    = var.rg_location        # Azure region
  resource_group_name         = var.rg_name            # Resource group name
  enabled_for_disk_encryption = true                   # Enable for disk encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id # Tenant ID
  soft_delete_retention_days  = 7                      # Soft delete retention (days)
  purge_protection_enabled    = false                  # Purge protection

  sku_name = "standard"                                # SKU pricing tier

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id # Access policy tenant ID
    object_id = data.azurerm_client_config.current.object_id # Access policy object ID

    key_permissions = [ "Get", "Create", "Delete", "Purge" ] # Key permissions
    secret_permissions = [ "Get", "Set", "List", "Delete", "Purge" ] # Secret permissions
    storage_permissions = [ "Get" ]                        # Storage permissions
  }
}
