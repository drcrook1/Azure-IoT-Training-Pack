###
# environment composition
###

resource "azurerm_resource_group" "base" {
  name     = "rg-ftaiot-${var.environment}-${var.region}"
  location = var.region
}

resource "random_string" "base" {
  length      = 5
  min_numeric = 5
  special     = false
}

module "azure_key_vault" {
  source                 = "./modules/azure_key_vault"
  environment            = var.environment
  region                 = var.region
  resource_group_name    = azurerm_resource_group.base.name
  random_string_result   = random_string.base.result
  kube_config            = module.azure_kubernetes_service.kube_config_raw
  dps_connection_string  = module.azure_iot_hub.dps_connection_string
  kusto_cluster_uri      = module.azure_data_explorer.data_explorer_cluster_uri
  kusto_cluster_database = module.azure_data_explorer.database_name
  kubelet_object_id      = module.azure_kubernetes_service.kubelet_identity_object_id
  tags                   = var.tags
}

module "azure_iot_hub" {
  source               = "./modules/azure_iot_hub"
  environment          = var.environment
  region               = var.region
  resource_group_name  = azurerm_resource_group.base.name
  random_string_result = random_string.base.result
  tags                 = var.tags
}

module "azure_data_explorer" {
  source                           = "./modules/azure_data_explorer"
  environment                      = var.environment
  region                           = var.region
  resource_group_name              = azurerm_resource_group.base.name
  random_string_result             = random_string.base.result
  tags                             = var.tags
  iothub_id                        = module.azure_iot_hub.iothub_id
  iothub_consumer_group            = module.azure_iot_hub.iothub_consumer_group
  iothub_shared_access_policy_name = module.azure_iot_hub.iothub_shared_access_policy_name
}

module "azure_kubernetes_service" {
  source               = "./modules/azure_kubernetes_service"
  environment          = var.environment
  region               = var.region
  resource_group_name  = azurerm_resource_group.base.name
  resource_group_id    = azurerm_resource_group.base.id
  random_string_result = random_string.base.result
  tags                 = var.tags
  address_space        = var.address_space
  address_prefixes     = var.address_prefixes
  key_vault_name       = module.azure_key_vault.name
}