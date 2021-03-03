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
}

##key vault secret

resource "random_string" "key_vault_secret" {
  length      = 16
  min_numeric = 3
  min_special = 3
  min_upper   = 3
  min_lower   = 3
  special     = true
}

resource "azurerm_key_vault_secret" "base" {
  name         = "sql-password"
  value        = random_string.key_vault_secret.result
  key_vault_id = azurerm_key_vault.base.id
}

