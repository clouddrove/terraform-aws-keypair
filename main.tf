##----------------------------------------------------------------------------------
## This terraform module is designed to generate consistent label names and
## tags for resources. You can use terraform-labels to implement a strict naming convention.
##----------------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  name        = var.name
  environment = var.environment
  repository  = var.repository
  attributes  = var.attributes
  label_order = var.label_order
  managedby   = var.managedby
}

##----------------------------------------------------------------------------------
## resource for generating or importing an SSH public key file into AWS.
##----------------------------------------------------------------------------------
resource "aws_key_pair" "default" {
  count = var.enable_key_pair ? 1 : 0

  key_name   = format("%s-pair", module.labels.id)
  public_key = var.public_key == "" ? trimspace(tls_private_key.default[0].public_key_openssh) : var.public_key

  tags = module.labels.tags
}

##----------------------------------------------------------------------------------
## resource for generating or importing an SSH private key file into AWS.
##----------------------------------------------------------------------------------

resource "tls_private_key" "default" {
  count = var.enable_key_pair && var.create_private_key_enabled ? 1 : 0

  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}