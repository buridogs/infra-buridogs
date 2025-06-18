output "resource_group_name" {
  value       = module.resource_group.name
  description = "Nome do Resource Group criado"
}

output "container_registry_url" {
  value       = module.container_registry.login_server
  description = "URL do Azure Container Registry"
  sensitive   = false
}

output "container_registry_username" {
  value       = module.container_registry.admin_username
  description = "Username do Azure Container Registry"
  sensitive   = true
}

output "container_registry_password" {
  value       = module.container_registry.admin_password
  description = "Password do Azure Container Registry"
  sensitive   = true
}

output "static_web_app_url" {
  value       = module.static_web_app.static_web_app_url
  description = "URL of the static web app"
}

output "sas_url_query_string" {
  value       = module.storage_account.sas_url_query_string
  description = "SAS URL query string for the storage account"
  sensitive   = true
}