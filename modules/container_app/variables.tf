variable "name" {
  type        = string
  description = "Nome do Container App"
}

variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region location"
}

variable "image" {
  type        = string
  description = "Container image to deploy"
}

variable "dns_zone_name" {
  type        = string
  description = "Nome da zona DNS (ex: buridogs.com)"
}

variable "tags" {
  type        = map(string)
  description = "Tags para recursos Azure"
  default     = {}
}

variable "registry_server" {
  type        = string
  description = "URL do Azure Container Registry"
}

variable "registry_username" {
  type        = string
  description = "Nome de usuário do Container Registry"
}

variable "registry_password" {
  type        = string
  description = "Senha do Container Registry"
  sensitive   = true
}