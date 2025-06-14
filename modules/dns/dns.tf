data "azurerm_dns_zone" "main" {
  name                = "buridogs.com.br"
  resource_group_name = "rg-buridogs"
}

resource "azurerm_dns_cname_record" "api" {
  name                = "api"
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = var.old_resource_group_name
  ttl                = 3600
  record             = var.container_app_url
  tags               = var.tags
}

resource "azurerm_dns_txt_record" "api_validation" {
  name                = "asuid.api"
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = var.old_resource_group_name
  ttl                = 3600
  tags               = var.tags

  record {
    value = var.domain_validation_token
  }
}

resource "azurerm_container_app_custom_domain" "domain" {
  container_app_id = var.container_app_id
  name      = "api.${data.azurerm_dns_zone.main.name}"

  lifecycle {
    // When using an Azure created Managed Certificate these values must be added to ignore_changes to prevent resource recreation.
    ignore_changes = [certificate_binding_type, container_app_environment_certificate_id]
  }
}