output "client_certificate" {
  value = module.azure_kubernetes_service.kube_config_client_certificate
}

output "kube_config" {
  value = module.azure_kubernetes_service.kube_config_raw
}