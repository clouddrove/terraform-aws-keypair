output "name" {
  value       = module.keypair.name
  description = "Name of SSH key."
}

output "key_pair_id" {
  value       = module.keypair.key_pair_id
  description = "The key pair ID."
}

output "public_key_openssh" {
  value       = module.keypair.public_key_openssh
  description = "The public key registered in AWS, in \"Authorized Keys\" format."
}

output "private_key_base64" {
  value       = module.keypair.private_key_base64
  sensitive   = true
  description = "Base64 encoded private key (empty when public_key is supplied). Decode with: terraform output -raw private_key_base64 | base64 -d"
}
