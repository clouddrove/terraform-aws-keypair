##----------------------------------------------------------------------------------
## This terraform module is designed to generate consistent label names and
## tags for resources. You can use terraform-labels to implement a strict naming convention.
##----------------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.1"

  name        = var.name
  environment = var.environment
  repository  = var.repository
  attributes  = var.attributes
  label_order = var.label_order
  managedby   = var.managedby
  extra_tags  = var.tags
}

##----------------------------------------------------------------------------------
## Local values.
## A key pair is generated automatically whenever no public key is supplied.
##----------------------------------------------------------------------------------
locals {
  public_key_supplied = trimspace(var.public_key) != ""
  generate_key        = var.enable_key_pair && !local.public_key_supplied

  key_name = var.key_name_prefix != null ? null : coalesce(var.key_name, format("%s-pair", module.labels.id))

  public_key_openssh = local.generate_key ? trimspace(tls_private_key.default[0].public_key_openssh) : trimspace(var.public_key)

  store_in_ssm            = local.generate_key && var.private_key_store == "ssm"
  store_in_secretsmanager = local.generate_key && var.private_key_store == "secretsmanager"

  ssm_parameter_name = coalesce(var.private_key_store_name, format("/%s/ssh-private-key", module.labels.id))
  secret_name        = coalesce(var.private_key_store_name, format("%s/ssh-private-key", module.labels.id))

  # Write-only arguments are not stored in state, so Terraform cannot detect a change in them.
  # Deriving the version from the generated key's id re-writes the secret whenever the key is regenerated.
  private_key_version = local.generate_key ? parseint(substr(tls_private_key.default[0].id, 0, 8), 16) : 0
}

##----------------------------------------------------------------------------------
## Guard rails (warnings only, never block an apply).
##----------------------------------------------------------------------------------
check "enable_private_key_is_deprecated" {
  assert {
    condition     = !var.enable_private_key
    error_message = "enable_private_key is deprecated and ignored. A key pair is generated automatically when public_key is empty."
  }
}

check "private_key_store_needs_generated_key" {
  assert {
    condition     = var.private_key_store == "none" || local.generate_key
    error_message = "private_key_store has no effect unless the module generates the key (enable_key_pair = true and public_key empty)."
  }
}

##----------------------------------------------------------------------------------
## resource for generating an SSH key (only when no public_key is supplied).
## NOTE: the generated private key is stored UNENCRYPTED in the Terraform state.
## For production, supply your own public_key and keep the private key out of Terraform.
##----------------------------------------------------------------------------------
resource "tls_private_key" "default" {
  count = local.generate_key ? 1 : 0

  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_algorithm == "RSA" ? var.private_key_rsa_bits : null
}

##----------------------------------------------------------------------------------
## resource for generating or importing an SSH public key file into AWS.
##----------------------------------------------------------------------------------
resource "aws_key_pair" "default" {
  count = var.enable_key_pair ? 1 : 0

  key_name        = local.key_name
  key_name_prefix = var.key_name_prefix
  public_key      = local.public_key_openssh

  tags = module.labels.tags

  lifecycle {
    precondition {
      condition     = var.key_name == null || var.key_name_prefix == null
      error_message = "key_name and key_name_prefix are mutually exclusive."
    }
  }
}

##----------------------------------------------------------------------------------
## Optional: keep the generated private key in SSM Parameter Store (SecureString).
## Uses a write-only argument, so this copy is not stored in state.
##----------------------------------------------------------------------------------
resource "aws_ssm_parameter" "private_key" {
  count = local.store_in_ssm ? 1 : 0

  name             = local.ssm_parameter_name
  description      = "SSH private key for EC2 key pair ${local.key_name != null ? local.key_name : var.key_name_prefix}"
  type             = "SecureString"
  tier             = "Intelligent-Tiering"
  key_id           = var.kms_key_id
  value_wo         = tls_private_key.default[0].private_key_openssh
  value_wo_version = local.private_key_version

  tags = module.labels.tags
}

##----------------------------------------------------------------------------------
## Optional: keep the generated private key in AWS Secrets Manager.
## Uses a write-only argument, so this copy is not stored in state.
##----------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "private_key" {
  count = local.store_in_secretsmanager ? 1 : 0

  name                    = local.secret_name
  description             = "SSH private key for EC2 key pair ${local.key_name != null ? local.key_name : var.key_name_prefix}"
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = var.secret_recovery_window_in_days

  tags = module.labels.tags
}

resource "aws_secretsmanager_secret_version" "private_key" {
  count = local.store_in_secretsmanager ? 1 : 0

  secret_id                = aws_secretsmanager_secret.private_key[0].id
  secret_string_wo         = tls_private_key.default[0].private_key_openssh
  secret_string_wo_version = local.private_key_version
}
