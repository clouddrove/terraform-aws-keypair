## Managed By : CloudDrove
##Description : This Script is used to create Key Pair.
## Copyright @ CloudDrove. All Right Reserved.

#Module      : labels
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "0.15.0"

  name        = var.name
  environment = var.environment
  repository  = var.repository
  attributes  = var.attributes
  label_order = var.label_order
  managedby   = var.managedby
}

#Module      : KEY PAIR
#Description : Terraform module for generating or importing an SSH public key file into AWS.
resource "aws_key_pair" "default" {
  count = var.enable_key_pair == true ? 1 : 0

  key_name   = module.labels.id
  public_key = var.public_key == "" ? file(var.key_path) : var.public_key
  tags       = module.labels.tags
}
