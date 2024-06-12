terraform {
  required_version = ">=0.12"

  required_providers {
    instaclustr = {
      source  = "instaclustr/instaclustr"
      version = "2.0.85"
    }
    azapi = {
      source  = "azure/azapi"
#      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
#      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
#      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  tenant_id = "${var.azure_tenant_id}" 
  client_id = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = false
      purge_soft_deleted_hardware_security_modules_on_destroy = true
    }
  }
}

/*
 Provisioning API Key is needed to provision cluster infra.
 API key is generated in Instaclustr console
 "Account Settings > API Keys; then locate the Provisioning roles"
 https://console2.instaclustr.com/login
*/

provider "instaclustr" {
  terraform_key = "Instaclustr-Terraform ${var.instaclustr_api_cred}"
}

