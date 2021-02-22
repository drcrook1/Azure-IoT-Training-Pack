resource "azurerm_storage_account" "appstorage" {
  name                     = "appstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "ftiotsql" {
  name                         = "mssqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "ftaiot"
  administrator_login_password = "David!234567890"

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.appstorage.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.appstorage.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = {
    environment = "production"
  }
}