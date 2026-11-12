locals {
  name        = "clouddrove"
  environment = "test"
  region      = "us-east-1"
  label_order = ["name", "environment"]
}

####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = local.region
}

####----------------------------------------------------------------------------------
##  Module      : KEY PAIR
##  public_key = ""  -> the module generates the key pair (private key is kept in the
##                      Terraform state, read it from the `private_key_base64` output).
##  public_key = "ssh-ed25519 AAAA..." -> the module imports your own public key instead.
####----------------------------------------------------------------------------------
module "keypair" {
  source = "../"

  name        = local.name
  environment = local.environment
  label_order = local.label_order

  public_key = ""
}
