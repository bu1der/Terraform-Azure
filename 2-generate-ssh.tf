resource "tls_private_key" "eschoolprod" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

locals {
  public_ssh_key = "${tls_private_key.eschoolprod.public_key_openssh}"
}