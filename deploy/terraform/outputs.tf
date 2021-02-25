output "client_certificate" {
  value = module.kubernetes.kube_config_client_certificate
}

output "kube_config" {
  value = module.kubernetes.kube_config_raw
}