# Retrieve the current Azure client configuration
data "azurerm_client_config" "current" {}

# Create a Key Vault secret for PostgreSQL
resource "azurerm_key_vault_secret" "pg_secret" {
  name         = "${var.db_name}-secret"  # Secret name based on database name
  value        = var.default_user_password  # Secret value (user password)
  key_vault_id = var.key_vault_id  # Key Vault ID where the secret is stored
}
