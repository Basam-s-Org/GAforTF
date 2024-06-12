### Azure Provider Credential Variables

variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_client_id" {
  type = string
}

variable "azure_client_secret" {
  type = string
}


### Resource Variables

# Azure Resource Group Name

variable "rg_name" {
  type = string
}

# Azure Resource Location

variable "rg_location" {
  type    = string
}


# Azure PostgreSQL database name

variable "db_name" {
  type    = string
}

# Default password generated at DB creation

variable "default_user_password" {
  type    = string
}

# ID of key vault to which the password is to be added

variable "key_vault_id" {
  type    = string
}


