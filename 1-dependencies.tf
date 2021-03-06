resource "azurerm_resource_group" "eschoolprod" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "eschoolprod" {
  name                = "${var.prefix}-network"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_network_security_group" "bastion" {
  name                = "${azurerm_resource_group.eschoolprod.name}-mgmt-nsg"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"

  security_rule {
    name                       = "allow-ssh"
    description                = "Allow SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "bastion" {
  name                      = "${azurerm_resource_group.eschoolprod.name}-bastion"
  virtual_network_name      = "${azurerm_virtual_network.eschoolprod.name}"
  resource_group_name       = "${azurerm_resource_group.eschoolprod.name}"
  address_prefix            = "10.0.0.128/25"
  network_security_group_id = "${azurerm_network_security_group.bastion.id}"
}

resource "azurerm_network_security_group" "web" {
  name                = "${azurerm_resource_group.eschoolprod.name}-web"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"

  security_rule {
    name                       = "allow-www"
    description                = "Allow HTTP Traffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-internal-ssh"
    description                = "Allow Internal SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "web" {
  name                      = "${azurerm_resource_group.eschoolprod.name}-web"
  virtual_network_name      = "${azurerm_virtual_network.eschoolprod.name}"
  resource_group_name       = "${azurerm_resource_group.eschoolprod.name}"
  address_prefix            = "10.0.1.0/24"
  network_security_group_id = "${azurerm_network_security_group.web.id}"
}