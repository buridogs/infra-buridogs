terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "buridogs-tfstate-rg"
    storage_account_name = "buridogstfstate"
    container_name      = "tfstate"
    key                 = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  source = "./modules/resource_group"
  name   = "${var.project_name}-${var.environment}-rg"
  location = var.location
  tags    = var.tags
}

module "container_registry" {
  source              = "./modules/container_registry"
  name                = "${var.project_name}${var.environment}acr"
  resource_group_name = module.resource_group.name
  location           = var.location
  tags               = var.tags

  depends_on = [
    module.resource_group
  ]
}

module "container_app" {
  source              = "./modules/container_app"
  name                = "${var.project_name}-api"
  resource_group_name = module.resource_group.name
  location           = var.location
  image              = "${module.container_registry.login_server}/${var.project_name}:latest"
  registry_server     = module.container_registry.login_server
  registry_username   = module.container_registry.admin_username
  registry_password   = module.container_registry.admin_password
  tags               = var.tags
  
  depends_on = [
    module.resource_group,
    module.container_registry
  ]
}

module "dns" {
  source                   = "./modules/dns"
  old_resource_group_name  = var.old_resource_group_name
  container_app_id         = module.container_app.id
  container_app_url        = module.container_app.app_url
  domain_validation_token  = module.container_app.domain_verification_token
  tags                    = var.tags

  depends_on = [
    module.container_app
  ]
}