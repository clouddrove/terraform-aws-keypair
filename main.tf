## Managed By : CloudDrove
##Description : This Script is used to create Key Pair.
## Copyright @ CloudDrove. All Right Reserved.

#Module      : KEY PAIR
#Description : Terraform module for generating or importing an SSH public key file into AWS.
resource "aws_key_pair" "default" {
  count = var.enable_key_pair == true ? 1 : 0

  key_name   = var.key_name
  public_key = file(var.key_path)
}