####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}

####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
module "keypair" {
  source = "./../"

  name        = "key"
  environment = "test"
  label_order = ["name", "environment"]

  public_key      = "ssh-rsa AAAAB3NqWk3Bw/NgygFXz7vob9OiA/fb2T3t4R1EwEs5rUX3uD2UBm6sbGBH00ZCjTHBwKHaGvKLk4c5gHX"
}
