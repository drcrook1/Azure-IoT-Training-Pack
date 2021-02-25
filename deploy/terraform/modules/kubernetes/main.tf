#resource group

resource "azurerm_resource_group" "base" {
  name     = "rg-${var.service_name}-${var.environment}-${var.region}"
  location = var.region
  tags     = var.tags
}

# virtual network

resource "azurerm_virtual_network" "base" {
  name                = "vnet-${var.name_prefix}-${var.environment}-${var.region}"
  resource_group_name = azurerm_resource_group.base.name
  address_space       = var.address_space
  location            = azurerm_resource_group.base.location
  tags                = var.tags

}

resource "azurerm_subnet" "base" {
  name                 = "snet-aks-${var.environment}-${var.region}"
  resource_group_name  = azurerm_resource_group.base.name
  address_prefixes     = var.address_prefixes
  virtual_network_name = azurerm_virtual_network.base.name
}

#kubernetes_cluster

resource "azurerm_kubernetes_cluster" "base" {
  name                = "${var.name_prefix}-${var.environment}-${var.region}"
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name
  node_resource_group = "${azurerm_resource_group.base.name}-nodes"
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = "${var.name_prefix}-${var.environment}-${var.region}-dns"

  default_node_pool {
    name                         = "systempool"
    only_critical_addons_enabled = true
    vm_size                      = var.vm_size
    availability_zones           = [1, 2, 3]
    node_count                   = 3
    vnet_subnet_id               = azurerm_subnet.base.id
    tags                         = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

#kubernetes_cluster_node_pool

resource "azurerm_kubernetes_cluster_node_pool" "base" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.base.id
  vm_size               = var.vm_size
  availability_zones    = [1, 2, 3]
  enable_auto_scaling   = true
  max_count             = 3
  min_count             = 1
  node_count            = 10
  mode                  = "User"
  vnet_subnet_id        = azurerm_subnet.base.id
  tags                  = var.tags
}
