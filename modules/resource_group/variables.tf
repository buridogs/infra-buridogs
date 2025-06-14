variable "name" {
  type        = string
  description = "Nome do Resource Group"
}

variable "location" {
  type        = string
  description = "Localização do Resource Group"
}

variable "tags" {
  type        = map(string)
  description = "Tags para o Resource Group"
  default     = {}
}