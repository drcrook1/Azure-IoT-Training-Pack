output "client_certificate" {
        value = azurerm_kubernetes_cluster.ftaiotaks.kube_config.0.client_certificate
}

output "kube_config" {
        value = azurerm_kubernetes_cluster.ftaiotaks.kube_config_raw
}

output "ingress_public_ip" {
        value = azurerm_public_ip.pip.ip_address
}