module "resource_group" {
  source = "./modules/resource_group/resource_group"
  name   = "${var.project_name}-${var.environment}-rg"
  location = var.location
  tags    = var.tags
}

module "container_registry" {
  source              = "./modules/container_registry/container_registry"
  resource_group_name = module.resource_group.name
  location           = var.location
  name               = "${var.project_name}${var.environment}acr"
  tags               = var.tags
}

module "container_app" {
  source              = "./modules/container_app/container_app"
  resource_group_name = module.resource_group.name
  location           = var.location
  name               = "${var.project_name}-api"
  image              = "${module.container_registry.login_server}/${var.project_name}:latest"
  custom_domain      = var.custom_domain
  depends_on         = [module.container_registry]
}