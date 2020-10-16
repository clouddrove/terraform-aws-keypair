provider "aws" {
  region = "eu-west-1"
}

module "keypair" {
  source = "./../"

  public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQ"
  key_name        = "devops"
  enable_key_pair = true
  environment     = "test"
}
