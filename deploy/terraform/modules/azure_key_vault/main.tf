#key vault

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "base" {
  name                      = lower("${var.name_prefix}-${var.environment}-${var.region}-${var.random_string_result}")
  location                  = var.region
  resource_group_name       = var.resource_group_name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization = false
  sku_name                  = "standard"
  tags                      = var.tags

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]
    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey",
    ]
    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.kubelet_object_id

    certificate_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]
    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey",
    ]
    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]
  }
}

##key vault secrets

resource "azurerm_key_vault_secret" "kubernetes" {
  name         = "kubeconfig"
  value        = var.kube_config
  key_vault_id = azurerm_key_vault.base.id
}

resource "azurerm_key_vault_secret" "dps_connection_string" {
  name         = "dps-connection-string"
  value        = var.dps_connection_string
  key_vault_id = azurerm_key_vault.base.id
}

resource "azurerm_key_vault_secret" "kusto_cluster" {
  name         = "kusto-cluster"
  value        = var.kusto_cluster_uri
  key_vault_id = azurerm_key_vault.base.id
}

resource "azurerm_key_vault_secret" "kusto_cluster_database" {
  name         = "kusto-database"
  value        = var.kusto_cluster_database
  key_vault_id = azurerm_key_vault.base.id
}