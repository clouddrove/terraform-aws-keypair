output "name" {
  value = concat(
    aws_key_pair.default.*.key_name
  )[0]
  description = "Name of SSH key."
}

