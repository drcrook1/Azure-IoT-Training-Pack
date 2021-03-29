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

#ingress pip

resource "azurerm_public_ip" "base" {
  name                = "pip-${var.name_prefix}-${var.environment}-${var.region}"
  location            = var.region
  resource_group_name = azurerm_kubernetes_cluster.base.node_resource_group
  sku                 = "Standard"
  allocation_method   = "Static"
}

#user assigned identity

resource "azurerm_user_assigned_identity" "base" {
  resource_group_name = var.resource_group_name
  location            = var.region
  name                = "mi-${var.name_prefix}-${var.environment}-${var.region}"
}

#role assignment

resource "azurerm_role_assignment" "base" {
  scope                = var.resource_group_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.base.principal_id
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
    type                      = "UserAssigned"
    user_assigned_identity_id = azurerm_user_assigned_identity.base.id
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

resource "azurerm_role_assignment" "acr" {
  scope                            = azurerm_container_registry.base.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_user_assigned_identity.base.principal_id
  skip_service_principal_aad_check = true
}

# helm provider

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.base.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.base.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.base.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.base.kube_config.0.cluster_ca_certificate)
  }
}

# azure csi driver

resource "helm_release" "csidriver" {
  depends_on = [azurerm_kubernetes_cluster.base]
  name       = "csi"
  repository = "https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts"
  chart      = "csi-secrets-store-provider-azure"

}

# ngninx ingress

resource "helm_release" "ingress" {
  name  = "ingress-controller"
  chart = "ingress-nginx/ingress-nginx"

  timeout = 1800

  set {
    name  = "rbac.create"
    value = "false"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.base.ip_address
  }

  set {
    name  = "controller.replicaCount"
    value = "1"
  }

  set {
    name  = "defaultBackend.enabled"
    value = "false"
  }

}
data "azurerm_client_config" "current" {
}

#kubernetes alpha provider

provider "kubernetes-alpha" {
  host                   = azurerm_kubernetes_cluster.base.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.base.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.base.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.base.kube_config.0.cluster_ca_certificate)
}

# secrets store provider deployment

resource "kubernetes_manifest" "secrets_store_provider" {
  depends_on = [azurerm_kubernetes_cluster.base]
  provider   = kubernetes-alpha

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1alpha1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "${var.key_vault_name}"
      "namespace" = "default"
    }
    "spec" = {
      "parameters" = {
        "cloudName"              = "AzurePublicCloud"
        "keyvaultName"           = "${var.key_vault_name}"
        "objects"                = <<-EOT
      array:
        - |
          objectName: kubeconfig
          objectType: secret        # object types: secret, key or cert
          objectVersion: ""         # [OPTIONAL] object versions, default to latest if empty
        - |
          objectName: dps-connection-string
          objectType: secret
          objectVersion: ""
        - |
          objectName: kusto-cluster
          objectType: secret
          objectVersion: ""
        - |
          objectName: kusto-database
          objectType: secret
          objectVersion: ""

      EOT
        "tenantId"               = "${data.azurerm_client_config.current.tenant_id}"
        "useVMManagedIdentity"   = "true"
        "userAssignedIdentityID" = "${azurerm_kubernetes_cluster.base.kubelet_identity.0.client_id}"
      }
      "provider" = "azure"
    }
  }
}
