# Specifies that the AzureRM provider is required for this configuration
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Data block to read the ACR username secret from Azure Key Vault
data "azurerm_key_vault_secret" "acr_username" {
  name         = var.acr_username_secret_name  # Name of the secret in Key Vault for ACR username
  key_vault_id = var.key_vault_id              # Key Vault ID
}

# Data block to read the ACR password secret from Azure Key Vault
data "azurerm_key_vault_secret" "acr_password" {
  name         = var.acr_password_secret_name  # Name of the secret in Key Vault for ACR password
  key_vault_id = var.key_vault_id              # Key Vault ID
}

# Defines an Azure Container Instance (ACI) resource
resource "azurerm_container_group" "org_container_group" {
  name                = var.aci_name          # Name of the ACI
  location            = var.rg_location       # Location of the resource group
  resource_group_name = var.rg_name           # Name of the resource group
  os_type             = "Linux"               # Operating system type for the container

  # Dynamic block to iterate over each dockerfile defined in the dockerfiles variable
  dynamic "container" {
    for_each = var.dockerfiles               # Loop over each Dockerfile
    iterator = dockerfile                    # Iterator to access each Dockerfile's properties

    # Defines the content for each container
    content {
      name   = dockerfile.value.image         # Name of the container
      image  = "${var.acr_login_server}/${dockerfile.value.image}:latest" # Image name with tag
      cpu    = var.aci_cpu                    # CPU allocation for the container
      memory = var.aci_memory                 # Memory allocation for the container

      # Command to keep the container running
      commands = ["/bin/bash", "-c", "while true; do sleep 30; done;"]

      # Dynamic block to define ports for the container
      dynamic "ports" {
        for_each = dockerfile.value.ports     # Loop over each port defined in the Dockerfile
        iterator = port                       # Iterator to access each port's properties
        content {
          port     = port.value               # Port number
          protocol = "TCP"                    # Protocol type
        }
      }

      # Environment variables for the container
      environment_variables = {
        POSTGRES_HOST     = var.pg_host       # PostgreSQL host
        POSTGRES_USER     = var.pg_user       # PostgreSQL user
        POSTGRES_PASSWORD = var.pg_password   # PostgreSQL password
        POSTGRES_DB       = var.pg_db         # PostgreSQL database name
      }

      # Secure environment variables for the container
      secure_environment_variables = {
        ACR_USERNAME = data.azurerm_key_vault_secret.acr_username.value # ACR username retrieved from Key Vault
        ACR_PASSWORD = data.azurerm_key_vault_secret.acr_password.value # ACR password retrieved from Key Vault
      }
    }
  }

  # Credentials to access the Azure Container Registry (ACR)
  image_registry_credential {
    server   = var.acr_login_server                                   # ACR login server
    username = data.azurerm_key_vault_secret.acr_username.value       # ACR username retrieved from Key Vault
    password = data.azurerm_key_vault_secret.acr_password.value       # ACR password retrieved from Key Vault
  }

  # Tags for the resource group
  tags = var.tags                                                     # Tags for organizing resources

  # Lifecycle settings to ensure the ACI is recreated before being destroyed
  lifecycle {
    create_before_destroy = true                                      # Create before destroy
  }
}
