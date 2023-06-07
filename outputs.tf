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
output "private_key_id" {
  value       = try(tls_private_key.default[0].*.id, "")
  description = "Unique identifier for this resource: hexadecimal representation of the SHA1 checksum of the resource"
}

output "public_key_openssh" {
  value       = try(trimspace(tls_private_key.default[0].public_key_openssh), "")
  description = "The public key data in \"Authorized Keys\" format. This is populated only if the configured private key is supported: this includes all `RSA` and `ED25519` keys"
}

output "public_key_pem" {
  value       = try(trimspace(tls_private_key.default[0].public_key_pem), "")
  description = "Public key data in PEM (RFC 1421) format"
}