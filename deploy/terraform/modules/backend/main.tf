#resource group

resource "azurerm_resource_group" "base" {
  name     = "rg-${var.service_name}-${var.environment}-${var.region}"
  location = var.region
  tags     = var.tags
}

#random string

resource "random_string" "base" {
  length      = 6
  min_numeric = 6
  special     = false
}

#storage account

resource "azurerm_storage_account" "base" {
  name                     = lower("st${substr(var.name_prefix, 0, 4)}${substr(var.environment, 0, 2)}${random_string.base.result}${substr(var.region, 0, 5)}")
  resource_group_name      = azurerm_resource_group.base.name
  location                 = azurerm_resource_group.base.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = var.tags
}

#sql server

resource "azurerm_sql_server" "base" {
  name                         = lower("sql-${var.name_prefix}-${var.environment}-${random_string.base.result}-${var.region}")
  resource_group_name          = azurerm_resource_group.base.name
  location                     = azurerm_resource_group.base.location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.base.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.base.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}