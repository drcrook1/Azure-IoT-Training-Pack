#Public IP
resource "azurerm_public_ip" "pip" {
        name                           =       "${var.name_prefix}-${var.environment}-${var.region}"
        location                       =       var.region
        resource_group_name            =       azurerm_kubernetes_cluster.base.node_resource_group
        allocation_method              =       "Static"
}

resource "helm_release" "ingress" {
  name  = "ingress-controller"
  chart = "stable/nginx-ingress"

  timeout = 1800

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.pip.ip_address
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