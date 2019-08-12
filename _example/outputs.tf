output "name" {
  value       = module.keypair.*.name
  description = "Name of SSH key."
}

