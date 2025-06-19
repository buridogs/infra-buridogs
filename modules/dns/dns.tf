resource "azurerm_dns_zone" "main" {
  name                = var.dns_zone_name
  resource_group_name = var.old_resource_group_name  # Use o resource group atual
  
  tags = var.tags
  
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_dns_cname_record" "api" {
  name                = "api"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.old_resource_group_name
  ttl                = 3600
  record             = var.container_app_url
  tags               = var.tags
}

resource "azurerm_dns_txt_record" "api_validation" {
  name                = "asuid.api"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.old_resource_group_name
  ttl                = 300
  tags               = var.tags

  record {
    value = var.domain_validation_token
  }
}

resource "azurerm_container_app_custom_domain" "domain" {
  container_app_id = var.container_app_id
  name      = "api.${azurerm_dns_zone.main.name}"

  lifecycle {
    // When using an Azure created Managed Certificate these values must be added to ignore_changes to prevent resource recreation.
    ignore_changes = [certificate_binding_type, container_app_environment_certificate_id]
  }

  depends_on = [
    azurerm_dns_cname_record.api,
    azurerm_dns_txt_record.api_validation
  ]
}