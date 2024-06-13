output "resource_group_name" {
  value = azurerm_resource_group.org_rg.name
}

output "acr_login_server" {
  value = module.container_registry.acr_login_server
}

output "acr_username" {
  value = module.container_registry.acr_username
}

output "acr_password" {
  value = module.container_registry.acr_password
  sensitive = true
}