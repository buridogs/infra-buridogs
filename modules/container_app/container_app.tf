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
      image  = var.image  # Temporary image. Use var.image after first release #mcr.microsoft.com/azuredocs/containerapps-helloworld:latest
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

  depends_on = [
    azurerm_container_app_environment.env
  ]
}

output "app_url" {
  value       = azurerm_container_app.app.ingress[0].fqdn
  description = "URL do Container App"
}

output "domain_verification_token" {
  value       = azurerm_container_app.app.custom_domain_verification_id
  description = "Token para validação do domínio customizado"
}

output "id" {
  value       = azurerm_container_app.app.id
  description = "ID do Container App"
}
