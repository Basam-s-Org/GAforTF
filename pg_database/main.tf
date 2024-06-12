# Retrieve the current Azure client configuration
data "azurerm_client_config" "current" {}

# Create a resource group in Azure
resource "azurerm_resource_group" "org_rg" {
  name     = var.rg_name      # Resource group name
  location = var.rg_location  # Resource group location
}

# Key Vault module for storing secrets
module "pg_database_key_vault" {
  source                = "./modules/key_vault"
  azure_subscription_id = var.azure_subscription_id  # Azure subscription ID
  azure_tenant_id       = var.azure_tenant_id        # Azure tenant ID
  azure_client_id       = var.azure_client_id        # Azure client ID
  azure_client_secret   = var.azure_client_secret    # Azure client secret
  rg_name               = var.rg_name                # Resource group name
  rg_location           = var.rg_location            # Resource group location
  db_secret_kv          = var.db_secret_kv           # Key Vault name for DB secrets
}

# PostgreSQL RDBMS module
module "pg_database_rdbms" {
  source                = "./modules/pg_database_rdbms"
  azure_subscription_id = var.azure_subscription_id  # Azure subscription ID
  azure_tenant_id       = var.azure_tenant_id        # Azure tenant ID
  azure_client_id       = var.azure_client_id        # Azure client ID
  azure_client_secret   = var.azure_client_secret    # Azure client secret
  instaclustr_api_cred  = var.instaclustr_api_cred   # Instaclustr API credentials
  rg_name               = var.rg_name                # Resource group name
  rg_location           = var.rg_location            # Resource group location
  db_name               = var.db_name                # Database name
  db_version            = var.db_version             # Database version
  db_secret_kv          = var.db_secret_kv           # Key Vault name for DB secrets
  db_extensions         = var.db_extensions          # PostgreSQL extensions to add
  dc_name               = var.dc_name                # Logical data centre name
  cloud_provider        = var.cloud_provider         # Using AZURE_AZ for Azure with ANF deployments 
}

# Firewall rules module
module "pg_database_firewall" {
  source               = "./modules/pg_database_firewall"
  instaclustr_api_cred = var.instaclustr_api_cred   # Instaclustr API credentials
  rg_name              = var.rg_name                # Resource group name
  rg_location          = var.rg_location            # Resource group location
  cluster_id           = module.pg_database_rdbms.cluster_id  # Cluster ID from RDBMS module
  firewall_rules       = var.firewall_rules         # Firewall rules
}

# Secret management module
module "pg_database_secret" {
  source                = "./modules/pg_database_secret"
  azure_subscription_id = var.azure_subscription_id  # Azure subscription ID
  azure_tenant_id       = var.azure_tenant_id        # Azure tenant ID
  azure_client_id       = var.azure_client_id        # Azure client ID
  azure_client_secret   = var.azure_client_secret    # Azure client secret
  rg_name               = var.rg_name                # Resource group name
  rg_location           = var.rg_location            # Resource group location
  db_name               = var.db_name                # Database name
  default_user_password = module.pg_database_rdbms.default_user_password  # User password from RDBMS module
  key_vault_id          = module.pg_database_key_vault.key_vault_id       # Key Vault ID from Key Vault module
}
