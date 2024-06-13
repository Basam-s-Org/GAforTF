variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "rg_location" {
  description = "The location of the resource group."
  type        = string
}

variable "aci_name" {
  description = "The name of the Azure Container Instance."
  type        = string
}

variable "acr_login_server" {
  description = "The login server of the Azure Container Registry."
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  type        = string
}

variable "acr_username_secret_name" {
  description = "The name of the secret in Key Vault for ACR username."
  type        = string
}

variable "acr_password_secret_name" {
  description = "The name of the secret in Key Vault for ACR password."
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
}

variable "tags" {
  description = "Tags for the resources."
  type        = map(string)
  default     = {}
}
