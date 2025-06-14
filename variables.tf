variable "old_resource_group_name" {
  type        = string
  description = "Nome do grupo de recursos ANTIGO na Azure"
}

variable "subscription_id" {
  type        = string
  description = "ID da assinatura Azure"
}

variable "project_name" {
  type        = string
  description = "Nome do projeto"
}

variable "environment" {
  type        = string
  description = "Ambiente (dev, staging, prod)"
}

variable "location" {
  type        = string
  description = "Região Azure"
}

variable "custom_domain" {
  type        = string
  description = "Domínio customizado para a API"
}

variable "tags" {
  type        = map(string)
  description = "Tags para recursos Azure"
}

variable "dns_zone_name" {
  type        = string
  description = "Nome da zona DNS (ex: buridogs.com)"
}