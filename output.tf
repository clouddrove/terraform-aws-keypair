output "name" {
  value       = "${var.create_key_pair == "true" ? join("", aws_key_pair.default.*.key_name) : ""}"
  description = "keypain name"
}

