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

resource "azurerm_storage_container" "shared_files" {
  name                  = "shared-files"
  storage_account_id    = azurerm_storage_account.tf_storage_account.id
  container_access_type = "blob"
}

resource "azurerm_storage_container" "adoption_form" {
  name                  = "adoption-form"
  storage_account_id    = azurerm_storage_account.tf_storage_account.id
  container_access_type = "blob"
}

resource "azurerm_storage_container" "dogs_management" {
  name                  = "dogs-management"
  storage_account_id    = azurerm_storage_account.tf_storage_account.id
  container_access_type = "blob"
}

resource "azurerm_storage_container" "partner_management" {
  name                  = "partner-management"
  storage_account_id    = azurerm_storage_account.tf_storage_account.id
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "example" {
  name                   = "prod.tfvars"
  storage_account_name   = azurerm_storage_account.tf_storage_account.name
  storage_container_name = azurerm_storage_container.tf_secret_container.name
  type                   = "Block"
  source                 = "./environments/prod.tfvars"
}

data "azurerm_storage_account_sas" "sa_sas" {
  connection_string = azurerm_storage_account.tf_storage_account.primary_connection_string
  https_only        = true
  signed_version    = "2022-11-02"

  resource_types {
    service   = true
    container = true
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2025-06-17T00:00:00Z"
  expiry = "2025-12-31T00:00:00Z"

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = false
    tag     = false
    filter  = false
  }
}

output "sas_url_query_string" {
  value = data.azurerm_storage_account_sas.sa_sas.sas
}