output "acr_name" {
  value = azurerm_container_registry.org_acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.org_acr.login_server
}

output "acr_username" {
  value = azurerm_container_registry.org_acr.admin_username
}

output "acr_password" {
  value = azurerm_container_registry.org_acr.admin_password
}
