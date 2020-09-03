provider "aws" {
  region = "eu-west-1"
}

module "keypair" {
  source = "./../"

  key_path        = "~/.ssh/id_rsa.pub"
  key_name        = "devops"
  enable_key_pair = true
}
