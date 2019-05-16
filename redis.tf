resource "azurerm_redis_cache" "eschoolprod" {
  name                = "${var.prefix}-cache"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {}
}