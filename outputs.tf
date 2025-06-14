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

output "container_app_outbound_ips" {
  value       = module.container_app.app_url
  description = "IP URL do Azure Container App"
}

output "domain_verification_token" {
  value       = module.container_app.domain_verification_token
  description = "Verificação do domínio customizado"
  sensitive   = false
}