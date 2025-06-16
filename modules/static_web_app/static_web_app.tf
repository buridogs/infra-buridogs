resource "azurerm_static_web_app" "tf-web-buridogs" {
  name                = "tf-web-buridogs"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags               = var.tags
  sku_tier                 = "Free"
  sku_size                 = "Free"
}

output "static_web_app_url" {
  value       = azurerm_static_web_app.tf-web-buridogs.default_host_name
  description = "URL of the static web app"
}