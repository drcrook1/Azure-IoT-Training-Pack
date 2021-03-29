output "kube_config" {
  value = module.azure_kubernetes_service.kube_config_raw
}

output "kubelet_identity_object_id" {
  value = module.azure_kubernetes_service.kubelet_identity_object_id
}
