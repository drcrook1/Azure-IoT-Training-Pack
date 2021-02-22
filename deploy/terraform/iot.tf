resource "azurerm_iothub_dps" "ftaiotdps" {
  name                = "fta-iot-dps"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = "S1"
    capacity = "1"
  }

  linked_hub {
    connection_string = "HostName=${azurerm_iothub.ftaiothub1.hostname};SharedAccessKeyName=iothubowner;SharedAccessKey=${azurerm_iothub.ftaiothub1.shared_access_policy.0.primary_key}"
    location          = azurerm_iothub.ftaiothub1.location
  }
}

resource "azurerm_iothub" "ftaiothub1" {
  name                = "fta-iot-hub-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = "S1"
    capacity = "1"
  }
}