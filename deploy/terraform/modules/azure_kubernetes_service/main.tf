# virtual network

resource "azurerm_virtual_network" "base" {
  name                = "vnet-${var.name_prefix}-${var.environment}-${var.region}"
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  location            = var.region
  tags                = var.tags

}

#subnet

resource "azurerm_subnet" "base" {
  name                 = "snet-${var.name_prefix}-${var.environment}-${var.region}"
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.address_prefixes
  virtual_network_name = azurerm_virtual_network.base.name
}

#kubernetes_cluster

resource "azurerm_kubernetes_cluster" "base" {
  name                = "${var.name_prefix}-${var.environment}-${var.region}"
  location            = var.region
  resource_group_name = var.resource_group_name
  node_resource_group = "${var.resource_group_name}-nodes"
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = "${var.name_prefix}-${var.environment}-${var.region}-dns"

  default_node_pool {
    name                         = "systempool"
    only_critical_addons_enabled = true
    vm_size                      = var.vm_size
    availability_zones           = [1, 2, 3]
    enable_auto_scaling          = true
    max_pods                     = 250
    max_count                    = 3
    min_count                    = 1
    node_count                   = 1
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
  max_count             = 10
  max_pods              = 250
  min_count             = 1
  node_count            = 1
  mode                  = "User"
  vnet_subnet_id        = azurerm_subnet.base.id
  tags                  = var.tags
}

#container registry

resource "azurerm_container_registry" "base" {
  name                = lower("cr${var.name_prefix}${var.environment}${var.region}${var.random_string_result}")
  resource_group_name = var.resource_group_name
  location            = var.region
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "base" {
  scope                            = azurerm_container_registry.base.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.base.identity[0].principal_id
  skip_service_principal_aad_check = true
}