#Module      : KEY PAIR
#Description : Terraform module key pair outputs.
output "name" {
  value       = join("", aws_key_pair.default[*].key_name)
  description = "Name of SSH key."
}

output "id" {
  value       = join("", aws_key_pair.default[*].id)
  description = "The key pair name."
}

output "arn" {
  value       = join("", aws_key_pair.default[*].arn)
  description = "The key pair ARN."
}

output "key_pair_id" {
  value       = one(aws_key_pair.default[*].key_pair_id)
  description = "The key pair ID (e.g. `key-0123456789abcdef0`)."
}

output "fingerprint" {
  value       = one(aws_key_pair.default[*].fingerprint)
  description = "The fingerprint of the key pair as reported by AWS."
}

output "private_key_id" {
  value       = join("", tls_private_key.default[*].id)
  description = "Unique identifier for the generated key: hexadecimal representation of the SHA1 checksum of the resource. Empty when a public_key is supplied."
}

output "public_key_openssh" {
  value       = local.public_key_openssh
  description = "The public key registered in AWS, in \"Authorized Keys\" format (generated or supplied)."
}

output "public_key_pem" {
  value       = join("", [for k in tls_private_key.default : trimspace(k.public_key_pem)])
  description = "Public key data in PEM (RFC 1421) format. Empty when a public_key is supplied."
}

output "public_key_fingerprint_sha256" {
  value       = join("", tls_private_key.default[*].public_key_fingerprint_sha256)
  description = "SHA256 fingerprint of the generated public key (e.g. `SHA256:...`). Empty when a public_key is supplied."
}

output "private_key_secret_arn" {
  value       = try(aws_secretsmanager_secret.private_key[0].arn, aws_ssm_parameter.private_key[0].arn, null)
  description = "ARN of the SSM parameter or Secrets Manager secret holding the generated private key. Null unless private_key_store is `ssm` or `secretsmanager`."
}

output "private_key_secret_name" {
  value       = try(aws_secretsmanager_secret.private_key[0].name, aws_ssm_parameter.private_key[0].name, null)
  description = "Name of the SSM parameter or Secrets Manager secret holding the generated private key. Null unless private_key_store is `ssm` or `secretsmanager`."
}

output "private_key_base64" {
  value       = join("", [for k in tls_private_key.default : base64encode(k.private_key_openssh)])
  sensitive   = true
  description = "Base64 encoded OpenSSH private key of the generated key pair (empty when a public_key is supplied). Base64 is encoding, not encryption: the key is also in the Terraform state, so protect the state. Decode with `terraform output -raw private_key_base64 | base64 -d`."
}
