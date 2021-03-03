resource "azurerm_kusto_cluster" "base" {
  name                = lower("${var.name_prefix}${var.environment}${var.region}${var.random_string_result}")
  location            = var.region
  resource_group_name = var.resource_group_name

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }
  tags = var.tags
}

resource "azurerm_kusto_database" "base" {
  name                = "${var.name_prefix}-database"
  resource_group_name = var.resource_group_name
  location            = var.region
  cluster_name        = azurerm_kusto_cluster.base.name
}

resource "azurerm_kusto_iothub_data_connection" "base" {
  name                      = "${var.name_prefix}-iothub-data-connection"
  resource_group_name       = var.resource_group_name
  location                  = var.region
  cluster_name              = azurerm_kusto_cluster.base.name
  database_name             = azurerm_kusto_database.base.name
  iothub_id                 = var.iothub_id
  consumer_group            = var.iothub_consumer_group
  shared_access_policy_name = var.iothub_shared_access_policy_name
}

