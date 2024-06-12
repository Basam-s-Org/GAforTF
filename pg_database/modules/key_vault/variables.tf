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

variable "db_secret_kv" {
  type    = string
}

