resource "azurerm_public_ip" "pip" {
  name                = "pip-fta-iot-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_kubernetes_cluster.ftaiotaks.node_resource_group
  allocation_method   = "Static"
}

provider "kubernetes" {
  host = azurerm_kubernetes_cluster.ftaiotaks.kube_config.0.host

  client_certificate     = base64decode(azurerm_kubernetes_cluster.ftaiotaks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.ftaiotaks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.ftaiotaks.kube_config.0.cluster_ca_certificate)
}

resource "azurerm_kubernetes_cluster" "ftaiotaks" {
  name                = "fta-iot-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "fta-iot-${var.environment}"
  kubernetes_version  = "1.19.7"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
