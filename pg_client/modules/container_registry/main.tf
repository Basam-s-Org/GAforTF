terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Creates an Azure Container Registry (ACR)
resource "azurerm_container_registry" "org_acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = "Basic"
  admin_enabled       = true
}

# Null resource to build and push Docker images to ACR
resource "null_resource" "docker_build_and_push" {
  for_each = var.dockerfiles

  triggers = {
    dockerfile_hash = filemd5("${path.module}/../../dockerfiles/Dockerfile.${each.value.image}")
  }

  provisioner "local-exec" {
    command = <<EOT
      az acr login --name ${azurerm_container_registry.org_acr.name} --username ${azurerm_container_registry.org_acr.admin_username} --password ${azurerm_container_registry.org_acr.admin_password}
      docker build -t ${azurerm_container_registry.org_acr.login_server}/${each.key}:latest -f ${path.module}/../../dockerfiles/Dockerfile.${each.value.image} ${path.module}
      docker push ${azurerm_container_registry.org_acr.login_server}/${each.key}:latest
      sleep 60  # Wait for the image to be available in ACR
    EOT
  }

  depends_on = [azurerm_container_registry.org_acr]
}

# Stores the ACR username as a secret in the Azure Key Vault
resource "azurerm_key_vault_secret" "acr_username" {
  name         = "${var.acr_name}-username"
  value        = azurerm_container_registry.org_acr.admin_username
  key_vault_id = var.key_vault_id

  depends_on = [azurerm_container_registry.org_acr]
}

# Stores the ACR password as a secret in the Azure Key Vault
resource "azurerm_key_vault_secret" "acr_password" {
  name         = "${var.acr_name}-password"
  value        = azurerm_container_registry.org_acr.admin_password
  key_vault_id = var.key_vault_id

  depends_on = [azurerm_container_registry.org_acr]
}
