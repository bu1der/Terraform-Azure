resource "azurerm_kubernetes_cluster" "eschoolprod" {
  name                = "${var.prefix}-k8s"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"
  dns_prefix          = "${var.prefix}-k8s"

  agent_pool_profile {
    name            = "default"
    count           = "${var.agent_count}"
    vm_size         = "Standard_DS2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${var.azure_client_id}"
    client_secret = "${var.azure_client_secret}"
  }

  tags = {
    Environment = "Production"
  }
}