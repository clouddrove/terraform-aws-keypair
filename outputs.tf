#Module      : KEY PAIR
#Description : Terraform module key pair outputs.
output "name" {
  value       = join("", aws_key_pair.default.*.key_name)
  description = "Name of SSH key."
}

output "id" {
  value       = join("", aws_key_pair.default.*.id)
  description = "The key pair name."
}

output "arn" {
  value       = join("", aws_key_pair.default.*.arn)
  description = "The key pair ARN."
}
