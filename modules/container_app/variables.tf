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
  description = "Localização do Container App"
}

variable "image" {
  type        = string
  description = "Imagem do container"
}

variable "custom_domain" {
  type        = string
  description = "Domínio customizado"
}

variable "ssl_cert_path" {
  type        = string
  description = "Caminho para o certificado SSL"
}

variable "ssl_cert_password" {
  type        = string
  description = "Senha do certificado SSL"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags para o Container App"
  default     = {}
}