resource "azurerm_log_analytics_workspace" "eschoolprod" {
  name                = "${var.prefix}-laworkspace"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"
  sku                 = "PerGB2018"
}