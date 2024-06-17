# Retrieve the current Azure client configuration
data "azurerm_client_config" "current" {}

# Create a resource group in Azure
resource "azurerm_resource_group" "app_rg" {
  name     = var.rg_name      # Resource group name
  location = var.rg_location  # Resource group location
}

locals {
   dc_name = var.dc_name == null ? "${var.cloud_provider}_${var.cloud_provider_region}" : var.dc_name
}


# storage network must be empty for non-ANF storage and is 10.3.0.0/24 by default for ANF
locals {
   dc_storage_network = length(regexall(".*ANF.*", var.db_node_size)) > 0 ? var.storage_network : ""
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
depends_on = [ azurerm_resource_group.app_rg ]
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
  db_node_size          = var.db_node_size           # Node size / SKU
  db_number_of_nodes    = var.db_number_of_nodes     # Numer of nodes in the database cluster
  db_secret_kv          = var.db_secret_kv           # Key Vault name for DB secrets
  db_extensions         = var.db_extensions          # PostgreSQL extensions to add
  db_replication_mode   = var.db_replication_mode    # SYNCHRONOUS (default) or ASYNCHRONOUS
  cloud_provider        = var.cloud_provider         # Using AZURE_AZ for Azure with ANF deployments 
  cloud_provider_region = var.cloud_provider_region  # Cloud provider region
  dc_name               = local.dc_name              # Logical data centre name
  dc_storage_network    = local.dc_storage_network   # Subnet for ANF storage
}

# Firewall rules module
module "pg_database_firewall" {
  source               = "./modules/pg_database_firewall"
  instaclustr_api_cred = var.instaclustr_api_cred   # Instaclustr API credentials
  rg_name              = var.rg_name                # Resource group name
  rg_location          = var.rg_location            # Resource group location
  cluster_id           = module.pg_database_rdbms.cluster_id  # Cluster ID from RDBMS module
  firewall_rules       = var.firewall_rules         # Firewall rules
  depends_on = [ 
    module.pg_database_key_vault,
    module.pg_database_rdbms
    ]
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
depends_on = [ module.pg_database_key_vault ]

}
