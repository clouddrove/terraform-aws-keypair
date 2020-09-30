variable "public_key" {
  type        = string
  default     = ""
  description = "Name  (e.g. `ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQ`)."
}

variable "key_path" {
  type        = string
  default     = ""
  description = "Name  (e.g. `~/.ssh/id_rsa.pub`)."
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `it-admin` or `devops`)."

}

variable "enable_key_pair" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable key pair."

}
variable "Tags"{
    type        = map(string)
    default     ={"FirstKey": "Env","SecondKey": "Prod"}
    description = "A tag is a custom label that you assign to an AWS resource. You can use tags to help organize and identify your key pairs."
}