variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "rg_location" {
  description = "The location of the resource group."
  type        = string
}

variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "dockerfiles" {
  description = "A map of Dockerfile names and corresponding image names."
  type        = map(object({
    image = string
    ports = list(number)
  }))
}

variable "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  type        = string
}
