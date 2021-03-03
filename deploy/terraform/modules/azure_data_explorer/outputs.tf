output "data_explorer_id" {
  value = azurerm_kusto_cluster.base.id
}

output "data_explorer_cluster_uri" {
  value = azurerm_kusto_cluster.base.uri
}

output "data_explorer_data_ingestion_uri" {
  value = azurerm_kusto_cluster.base.data_ingestion_uri
}