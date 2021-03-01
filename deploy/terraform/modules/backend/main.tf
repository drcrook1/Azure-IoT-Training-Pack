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

#sql server

resource "azurerm_sql_server" "base" {
  name                         = lower("sql-${var.name_prefix}-${var.environment}-${random_string.base.result}-${var.region}")
  resource_group_name          = azurerm_resource_group.base.name
  location                     = azurerm_resource_group.base.location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  tags                         = var.tags
}

resource "azurerm_sql_database" "base" {
  name                = "ftaiotdb"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  server_name         = azurerm_sql_server.base.name
  tags                = var.tags
}

