variable "resource_group_name" {
  description = "The name of the resource group where the static web app will be created."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group where the static web app will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the static web app."
  type        = map(string)
  default     = {}
}