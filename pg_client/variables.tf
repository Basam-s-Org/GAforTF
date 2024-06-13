variable "azure_subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "azure_tenant_id" {
  description = "The Azure tenant ID."
  type        = string
}

variable "azure_client_id" {
  description = "The Azure client ID."
  type        = string
}

variable "azure_client_secret" {
  description = "The Azure client secret."
  type        = string
  sensitive   = true
}

variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "rg_location" {
  description = "The location of the resource group."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "aci_name" {
  description = "The name of the Azure Container Instance."
  type        = string
}

variable "pg_host" {
  description = "The PostgreSQL server address."
  type        = string
}

variable "pg_user" {
  description = "The PostgreSQL username."
  type        = string
}

variable "pg_password" {
  description = "The PostgreSQL password."
  type        = string
  sensitive   = true
}

variable "pg_db" {
  description = "The PostgreSQL database name."
  type        = string
}

variable "aci_cpu" {
  description = "The CPU allocation for the container instance."
  type        = number
}

variable "aci_memory" {
  description = "The memory allocation for the container instance."
  type        = number
}

variable "dockerfiles" {
  description = "A map of Dockerfile names and corresponding image names."
  type        = map(object({
    image = string
    ports = list(number)
  }))
  default     = {}
}

variable "tags" {
  description = "Tags for the resources."
  type        = map(string)
  default     = {}
}
