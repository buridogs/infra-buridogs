resource "azurerm_dns_zone" "main" {
  name                = "buridogs.com"
  resource_group_name = var.old_resource_group_name
  tags                = var.tags
}

resource "azurerm_dns_cname_record" "api" {
  name                = "api"
  zone_name           = azurerm_dns_zone.main.name
  resource_group_name = var.old_resource_group_name
  ttl                = 3600
  record             = var.container_app_url
  tags               = var.tags
}

# resource "azurerm_dns_txt_record" "api_validation" {
#   name                = "asuid.api"
#   zone_name           = azurerm_dns_zone.main.name
#   resource_group_name = var.old_resource_group_name
#   ttl                = 3600
#   tags               = var.tags

#   record {
#     value = var.domain_validation_token
#   }
# }