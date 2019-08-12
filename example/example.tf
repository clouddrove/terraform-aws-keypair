module "keypair" {
  source   = "../"
  key      = "${file("~/.ssh/id_rsa.pub")}"
  key_name = "devops"
}
