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

output "private_key_id" {
  value       = module.keypair.*.private_key_id
  description = "Unique identifier for this resource: hexadecimal representation of the SHA1 checksum of the resource"
}

output "public_key_openssh" {
  value       = module.keypair.*.public_key_openssh
  description = "The public key data in \"Authorized Keys\" format. This is populated only if the configured private key is supported: this includes all `RSA` and `ED25519` keys"
}

output "public_key_pem" {
  value       = module.keypair.*.public_key_pem
  description = "Public key data in PEM (RFC 1421) format"
}