# Retrieves the current Azure client configuration (useful for obtaining the object ID of the service principal)
data "azurerm_client_config" "current" {}

# Creates an Azure resource group
resource "azurerm_resource_group" "org_rg" {
  name     = var.rg_name
  location = var.rg_location
}

# Key Vault module to create and manage an Azure Key Vault
module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  location            = var.rg_location
  resource_group_name = azurerm_resource_group.org_rg.name
  tenant_id           = var.azure_tenant_id
  object_id           = data.azurerm_client_config.current.object_id
}

# Container Registry module to create and manage an Azure Container Registry and store credentials in AKV
module "container_registry" {
  source      = "./modules/container_registry"
  rg_name     = azurerm_resource_group.org_rg.name
  rg_location = var.rg_location
  acr_name    = var.acr_name
  dockerfiles = var.dockerfiles
  key_vault_id = module.key_vault.key_vault_id

  # Ensure the Key Vault is created before the Container Registry
  depends_on = [module.key_vault]
}

# Container Instance module to create and manage an Azure Container Instance, retrieving ACR credentials from AKV
module "container_instance" {
  source                    = "./modules/container_instance"
  rg_name                   = azurerm_resource_group.org_rg.name
  rg_location               = var.rg_location
  aci_name                  = var.aci_name
  acr_login_server          = module.container_registry.acr_login_server
  acr_username_secret_name  = "${module.container_registry.acr_name}-username"
  acr_password_secret_name  = "${module.container_registry.acr_name}-password"
  key_vault_id              = module.key_vault.key_vault_id
  pg_host                   = var.pg_host
  pg_user                   = var.pg_user
  pg_password               = var.pg_password
  pg_db                     = var.pg_db
  aci_cpu                   = var.aci_cpu
  aci_memory                = var.aci_memory
  dockerfiles               = var.dockerfiles
  tags                      = var.tags

  # Ensure the Container Registry is created before the Container Instance
  depends_on = [module.container_registry]
}
