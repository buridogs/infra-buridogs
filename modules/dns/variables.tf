variable "old_resource_group_name" {
  type        = string
  description = "Nome do Resource Group ANTIGO"
}

variable "container_app_url" {
  type        = string
  description = "URL do Container App"
}

# variable "domain_validation_token" {
#   type        = string
#   description = "Token de validação do domínio"
# }

variable "tags" {
  type        = map(string)
  description = "Tags para recursos Azure"
  default     = {}
}