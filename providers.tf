terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }

  backend "api-buridogs" {
    resource_group_name  = "buridogs-tfstate-rg"
    storage_account_name = "buridogstfstate"
    container_name      = "tfstate"
    key                 = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}