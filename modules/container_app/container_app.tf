resource "azurerm_container_app_environment" "env" {
  name                = "${var.name}-env"
  resource_group_name = var.resource_group_name
  location           = var.location
  tags               = var.tags
}

resource "azurerm_container_app" "app" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name         = var.resource_group_name
  revision_mode               = "Single"

  template {
    container {
      name   = "api"
      image  = var.image
      cpu    = "0.5"
      memory = "1Gi"

      env {
        name  = "NODE_ENV"
        value = "production"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port     = 3000
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  secret {
    name  = "registry-password"
    value = var.registry_password
  }

  registry {
    server   = var.registry_server
    username = var.registry_username
    password_secret_name = "registry-password"
  }

  tags = var.tags
}

resource "azurerm_container_app_custom_domain" "domain" {
  container_app_id = azurerm_container_app.app.id
  name      = "api.${var.dns_zone_name}"

  lifecycle {
    // When using an Azure created Managed Certificate these values must be added to ignore_changes to prevent resource recreation.
    ignore_changes = [certificate_binding_type, container_app_environment_certificate_id]
  }

  depends_on = [
    azurerm_container_app.app
  ]
}

output "app_url" {
  value       = azurerm_container_app.app.latest_revision_fqdn
  description = "URL do Container App"
}

output "domain_verification_token" {
  value       = azurerm_container_app_custom_domain.domain
  description = "Token para validação do domínio customizado"
}
