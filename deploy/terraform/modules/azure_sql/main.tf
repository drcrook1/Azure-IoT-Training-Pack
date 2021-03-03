#random string

resource "random_string" "base" {
  length      = 6
  min_numeric = 6
  special     = false
}

#sql server

resource "azurerm_sql_server" "base" {
  name                         = lower("${var.name_prefix}-${var.environment}-${var.region}-${var.random_string_result}")
  resource_group_name          = var.resource_group_name
  location                     = var.region
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  tags                         = var.tags
}

resource "azurerm_sql_database" "base" {
  name                = "iotdb"
  resource_group_name = var.resource_group_name
  location            = var.region
  server_name         = azurerm_sql_server.base.name
  tags                = var.tags
}

