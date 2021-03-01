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

#key vault

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "base" {
  name                      = lower("kv${var.name_prefix}${substr(var.environment, 0, 2)}${random_string.base.result}${var.region}")
  location                  = azurerm_resource_group.base.location
  resource_group_name       = azurerm_resource_group.base.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization = false
  sku_name                  = "standard"
  tags                      = var.tags
}

##key vault access policy

resource "azurerm_key_vault_access_policy" "base" {
  key_vault_id = azurerm_key_vault.base.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
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

