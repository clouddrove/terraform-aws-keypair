provider "aws" {
  region = "eu-west-1"
}

module "keypair" {
  source = "./../"

  name        = "key"
  environment = "test"
  label_order = ["name", "environment"]

  enable_key_pair = true
  public_key      = "ssh-rsa AAAAB3NqWk3Bw/NgygFXz7vob9OiA/fb2T3t4R1EwEs5rUX3uD2UBm6sbGBH00ZCjTHBwKHaGvKLk4c5gHX"
}
