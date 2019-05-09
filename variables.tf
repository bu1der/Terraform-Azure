#Basic
variable "azure_subscription_id" {
  type = "string"
}

variable "azure_client_id" {
  type = "string"
}

variable "azure_client_secret" {
  type = "string" 
}

variable "asure_tenant_id" {
  type = "string"
}

#Group
variable "prefix" {
  description = "The prefix used for all resources in this example"
  default = "eschool"
}

variable "location" {
  description = "The zone that the machine should be created in"
  default = "West Europe"
}

#VM
variable "type" {
  description = "Accaunt type plan"
  default = "Standard_LRS"
}

variable "disk_size" {
  description = "Disk size Gb"
  default = "1024"
}

variable "vm_size" {
  description = "The azurerm virtual machine type plan"
  default = "Standard_D2s_v3"
}

#OS

variable "publisher" {
  description = "The image publisher"
  default = "OpenLogic"
}

variable "offer" {
  description = "The image offer(OS)"
  default = "CentOS"
}

variable "sku" {
  description = "The image relise number"
  default = "7.5"
}

variable "version" {
  description = "The image version"
  default = "latest"
}

variable "storage_data_disk" {
  description = "Disk size Gb"
  default = "1024"
}

variable "admin_username" {
  description = "Accaunt admin name"
  default = "user123456"
}

variable "admin_password" {
  description = "Accaunt admin password"
  default = "Qwerty123456"
}

variable "disable_password_authentication" {
  description = "Disable password authentication"
  default = "false"
}




