####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}

####----------------------------------------------------------------------------------
##  Module      : KEY PAIR
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
module "keypair" {
  source = "./../"

  name                       = "key"
  environment                = "test"
  label_order                = ["environment", "name"]

  public_key                 = ""
  create_private_key_enabled = true
  enable_key_pair            = true
}
