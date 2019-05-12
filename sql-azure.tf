resource "azurerm_sql_server" "eschoolprod" {
  name                         = "${var.prefix}-sqlsvr"
  resource_group_name          = "${azurerm_resource_group.eschoolprod.name}"
  location                     = "${azurerm_resource_group.eschoolprod.location}"
  version                      = "12.0"
  administrator_login          = "${var.administrator_login}"
  administrator_login_password = "${var.administrator_login_password}"
}

resource "azurerm_sql_database" "eschoolprod" {
  name                             = "${var.prefix}-db"
  resource_group_name              = "${azurerm_resource_group.eschoolprod.name}"
  location                         = "${azurerm_resource_group.eschoolprod.location}"
  server_name                      = "${azurerm_sql_server.eschoolprod.name}"
  edition                          = "Basic"
  collation                        = "SQL_Latin1_General_CP1_CI_AS"
  create_mode                      = "Default"
  requested_service_objective_name = "Basic"
}

# Enables the "Allow Access to Azure services" box as described in the API docs
# https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
resource "azurerm_sql_firewall_rule" "eschoolprod" {
  name                = "allow-azure-services"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"
  server_name         = "${azurerm_sql_server.eschoolprod.name}"
  start_ip_address    = "10.0.0.10"
  end_ip_address      = "10.0.0.40"
}