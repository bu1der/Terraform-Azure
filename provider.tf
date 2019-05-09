# Specify the provider (GCP, AWS, Azure)
provider "azurerm" {
  version = "~> 1.27"
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.asure_tenant_id}"
  }
