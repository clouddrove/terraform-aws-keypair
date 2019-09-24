output "name" {
  value       = join("", aws_key_pair.default.*.key_name)
  description = "Name of SSH key."
}