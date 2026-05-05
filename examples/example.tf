####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}

####----------------------------------------------------------------------------------
##  Module      : KEY PAIR
## Terraform module for generating or importing an SSH public key file into AWS.
####----------------------------------------------------------------------------------
module "keypair" {
  source = "../"

  name        = "key"
  environment = "test"
  label_order = ["environment", "name"]

  public_key         = "XXXXXXXXXXXXXX"
  enable_private_key = true
  enable_key_pair    = true
}
