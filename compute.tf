locals {
  virtual_machine_name = "${var.prefix}-vm"
  admin_username       = "testadmin"
}

resource "azurerm_network_interface" "eschoolprod" {
  name                      = "${azurerm_resource_group.eschoolprod.name}-nic"
  location                  = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name       = "${azurerm_resource_group.eschoolprod.name}"
  network_security_group_id = "${azurerm_network_security_group.bastion.id}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${azurerm_subnet.bastion.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.eschoolprod.id}"
  }
}

resource "azurerm_public_ip" "eschoolprod" {
  name                = "${var.prefix}-bastionpip"
  location            = "${azurerm_resource_group.eschoolprod.location}"
  resource_group_name = "${azurerm_resource_group.eschoolprod.name}"
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_machine" "eschoolprod" {
  name                  = "${local.virtual_machine_name}"
  location              = "${azurerm_resource_group.eschoolprod.location}"
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
    managed_disk_type = "${var.type}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

    storage_data_disk {
    name              = "${var.prefix}-dataprod"
    managed_disk_type = "${var.type}"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "${var.storage_data_disk}"
  }

  os_profile {
    computer_name  = "${var.prefix}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = "${var.disable_password_authentication}"

    # ssh_keys {
    #   path     = "/home/${local.admin_username}/.ssh/authorized_keys"
    #   key_data = "${local.public_ssh_key}"
    # }
  }
}