data "azurerm_client_config" "current" {}

output "account_id" {
  value = "${data.azurerm_client_config.current.service_principal_application_id}"
}

output "id" {
  value = "${azurerm_kubernetes_cluster.eschoolprod.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.eschoolprod.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.eschoolprod.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.eschoolprod.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.eschoolprod.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.eschoolprod.kube_config.0.host}"
}