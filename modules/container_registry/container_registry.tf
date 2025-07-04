resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location           = var.location
  sku                = "Basic"
  admin_enabled      = true
  tags               = var.tags
}

output "login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}