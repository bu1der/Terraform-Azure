# Create a resource group
resource "azurerm_resource_group" "eschoolprod" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "eschoolprod" {
  name                = "${var.prefix}-network"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "eschoolprod" {
  name                 = "${var.prefix}-subnetwork"
  resource_group_name  = "${azurerm_resource_group.eschoolprod.name}"
  virtual_network_name = "${azurerm_virtual_network.eschoolprod.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_network_interface" "eschoolprod" {
  name                = "${var.prefix}-net"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"

  ip_configuration {
    name                          = "${var.prefix}-ipconf"
    subnet_id                     = "${azurerm_subnet.eschoolprod.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_managed_disk" "eschoolprod" {
  name                  = "${var.prefix}-data"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.eschoolprod.name}"
  storage_account_type  = "${var.type}"
  create_option         = "Empty"
  disk_size_gb          = "${var.disk_size}"
}

resource "azurerm_virtual_machine" "eschoolprod" {
  name                  = "${var.prefix}-vm"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.eschoolprod.name}"
  network_interface_ids = ["${azurerm_network_interface.eschoolprod.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "${var.publisher}"
    offer     = "${var.offer}"
    sku       = "${var.sku}"
    version   = "${var.version}"
  }

  storage_os_disk {
    name              = "${var.prefix}-osdiskprod"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.type}"
  }

  storage_data_disk {
    name              = "${var.prefix}-dataprod"
    managed_disk_type = "${var.type}"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "${var.storage_data_disk}"
  }

  os_profile {
    computer_name = "${var.prefix}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = "${var.disable_password_authentication}"
  }

}






