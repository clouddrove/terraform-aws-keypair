provider "aws" {
  region = "eu-west-1"
}

module "keypair" {
  source = "./../"

  key_path        = "/home/runner/work/terraform-aws-keypair/terraform-aws-keypair/id_rsa.pub" # You have to put '~/.ssh/id_rsa.pub' here
  key_name        = "devops"
  enable_key_pair = true
  environment     = "test"
}
