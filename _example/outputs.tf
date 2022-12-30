output "name" {
  value       = module.keypair.*.name
  description = "Name of SSH key."
}

output "id" {
  value       = module.keypair.*.arn
  description = "The key pair name."
}

output "arn" {
  value       = module.keypair.*.id
  description = "The key pair ARN."
}