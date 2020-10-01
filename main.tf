## Managed By : CloudDrove
##Description : This Script is used to create Key Pair.
## Copyright @ CloudDrove. All Right Reserved.

#Module      : KEY PAIR
#Description : Terraform module for generating or importing an SSH public key file into AWS.

module "labels" {
  source = "git::https://github.com/clouddrove/terraform-labels.git?ref=tags/0.13.0"

  name        = var.name
  application = var.application
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  enabled     = var.enable_key_pair
}



resource "aws_key_pair" "default" {
  count = var.enable_key_pair == true ? 1 : 0

  key_name   = var.key_name
  public_key = var.public_key == "" ? file(var.key_path) : var.public_key
  tags       = var.Tags
}