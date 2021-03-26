###
#  module outputs
###

output "id" {
  value = azurerm_kubernetes_cluster.base.id
}

output "name" {
  value = azurerm_kubernetes_cluster.base.name
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.base.fqdn
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.base.node_resource_group
}

output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.base.kube_config_raw
}

output "kube_config_client_key" {
  value = azurerm_kubernetes_cluster.base.kube_config.0.client_key
}

output "kube_config_client_certificate" {
  value = azurerm_kubernetes_cluster.base.kube_config.0.client_certificate
}

output "kube_config_cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.base.kube_config.0.cluster_ca_certificate
}

output "kube_config_host" {
  value = azurerm_kubernetes_cluster.base.kube_config.0.host
}

output "kube_config_username" {
  value = azurerm_kubernetes_cluster.base.kube_config.0.username
}

output "kube_config_password" {
  value = azurerm_kubernetes_cluster.base.kube_config.0.password
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.base.kubelet_identity.0.object_id
}

output "acr_name" {
  value = azurerm_container_registry.base.name
}