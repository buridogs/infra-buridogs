resource "azurerm_storage_account" "tf_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags                     = var.tags
}

resource "azurerm_storage_container" "tf_secret_container" {
  name                  = "tf-secrets"
  storage_account_id    = azurerm_storage_account.tf_storage_account.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "prod.tfvars"
  storage_account_name   = azurerm_storage_account.tf_storage_account.name
  storage_container_name = azurerm_storage_container.tf_secret_container.name
  type                   = "Block"
  source                 = "./environments/prod.tfvars"
}