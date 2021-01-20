provider "aws" {
  region = "eu-west-1"
}

module "keypair" {
  source = "./../"

  name        = "key"
  environment = "test"
  label_order = ["name", "environment"]

  enable_key_pair = true
  public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfjNc4A+atuEBaElnpQqFkBFgGc+kCslpXh/aKETl1Wh95tOy9IWHomegVxKB44OvB5s6I6HFwRa8MCpcAUnW3vD7hBwOv+PgJ0ZFUGYrl71doDHsWtfgoRhrKlhk2jjS7gOZrrYK2vg0859knhrmRQEm6snqFdZ6bLc6R/r0htgtgUx9mESZHfupL/lylOjBiEboQxpo1lp2MKEmksv5q+8A60ZN+mTEj6M4Zmbiw7ypGjcK8utgOyoJ58uWIMt76VW46M6FIGVymwnqBm5PUgThzTPhwVpIc4kTw2Ko1CF4l8fhHNHr698NNTkpol5QvFiBZIgbTGF9RBJyYpGN1XupY4UCrwLBFb5Sigu42lCfb2/wpuAPk5LpoUhdvrDYyzxMdFy0AhIs+3my9D5jNs2rHywoYzcGfrEwi8tLHRqaV+nOI4URk7GenzAQWbUeKwosgSyVv4XnAFrtHMx2oUN5iqAMwFeZH67gw9BkATiF0ZhExCHGILcLZTNJP2N0= anmol@clouddrove-Lenov"
}
