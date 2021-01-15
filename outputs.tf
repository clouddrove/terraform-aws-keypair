#Module      : KEY PAIR
#Description : Terraform module for generating or importing an SSH public key file into AWS.
output "name" {
  value       = join("", aws_key_pair.default.*.key_name)
  description = "Name of SSH key."
}
