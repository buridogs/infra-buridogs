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
    custom_domain {
      name            = var.custom_domain
      certificate_id  = azurerm_container_app_environment_certificate.cert.id
    }
  }

  registry {
    server   = split("/", var.image)[0]
    identity = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_container_app_environment_certificate" "cert" {
  name                         = "${var.name}-cert"
  container_app_environment_id = azurerm_container_app_environment.env.id
  certificate_value           = filebase64(var.ssl_cert_path)
  password                    = var.ssl_cert_password
}