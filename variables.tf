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
variable prefix {
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

#Kubernetes

variable "agent_count" {
  description = "Kubernetes count nodes"
  default = 1
}

variable "vm_size_kub" {
  description = "Kubernetes virtual machine type"
  default = "Standard_DS2_v2"
}

variable "os_type" {
  description = "Kubernetes OS type"
  default = "Linux"
}

variable "os_disk_size_gb" {
  description = "Kubernetes count nodes"
  default = 30
}

#Azure SQL database
variable "administrator_login" {
  description = "Azure SQL database administrator login"
  default = "4dm1n157r470r"
}

variable "administrator_login_password" {
  description = "Azure SQL database administrator login"
  default = "4-v3ry-53cr37-p455w0rd"
}