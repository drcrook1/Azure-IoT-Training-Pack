#resource group

resource "azurerm_resource_group" "base" {
  name     = "rg-${var.service_name}-${var.environment}-${var.region}"
  location = var.region
  tags     = var.tags
}

# random string

resource "random_string" "base" {
  length      = 6
  min_numeric = 6
  special     = false
}

#iot hub

resource "azurerm_iothub" "base" {
  name                = "iot-hub-${var.name_prefix}-${random_string.base.result}"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location

  sku {
    name     = var.hub_sku_name
    capacity = var.hub_sku_capacity
  }
}

#iot hub dps

resource "azurerm_iothub_dps" "base" {
  name                = "iot-dps-${var.name_prefix}-${random_string.base.result}"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location

  sku {
    name     = var.dps_sku_name
    capacity = var.dps_sku_capacity
  }

  linked_hub {
    connection_string = "HostName=${azurerm_iothub.base.hostname};SharedAccessKeyName=iothubowner;SharedAccessKey=${azurerm_iothub.base.shared_access_policy.0.primary_key}"
    location          = azurerm_resource_group.base.location
  }
}