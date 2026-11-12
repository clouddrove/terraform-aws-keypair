#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-keypair"
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "label order, e.g. `name`,`application`."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

#Module      : KEY PAIR module variables.
variable "public_key" {
  type        = string
  default     = ""
  description = "OpenSSH public key to import into AWS (e.g. `ssh-ed25519 AAAAC3...`). Leave empty to have the module generate a key pair automatically. Never pass a private key here."

  validation {
    condition     = !strcontains(var.public_key, "PRIVATE KEY")
    error_message = "public_key looks like private key material. Provide the PUBLIC key only."
  }
}

variable "enable_key_pair" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable key pair."
}

variable "key_name" {
  type        = string
  default     = null
  description = "Name of the EC2 key pair. Defaults to `<label id>-pair`. Conflicts with `key_name_prefix`."
}

variable "key_name_prefix" {
  type        = string
  default     = null
  description = "Creates a unique key pair name beginning with this prefix. Conflicts with `key_name`."
}

#      : PRIVATE KEY
variable "enable_private_key" {
  type        = bool
  default     = false
  description = "DEPRECATED and ignored. A key pair is now generated automatically whenever `public_key` is empty."
}

variable "private_key_algorithm" {
  type        = string
  default     = "RSA"
  description = "Algorithm used when generating the key pair. Supported values are `RSA` and `ED25519` (the algorithms EC2 accepts). ED25519 is recommended for new keys but is not supported on Windows instances."

  validation {
    condition     = contains(["RSA", "ED25519"], var.private_key_algorithm)
    error_message = "private_key_algorithm must be `RSA` or `ED25519`."
  }
}

variable "private_key_rsa_bits" {
  type        = number
  default     = 4096
  description = "When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`)"

  validation {
    condition     = contains([2048, 3072, 4096], var.private_key_rsa_bits)
    error_message = "private_key_rsa_bits must be one of 2048, 3072 or 4096."
  }
}

#      : PRIVATE KEY STORAGE
variable "private_key_store" {
  type        = string
  default     = "none"
  description = "Where to keep a generated private key: `none` (state only), `ssm` (SSM Parameter Store SecureString) or `secretsmanager` (AWS Secrets Manager). Only used when the module generates the key."

  validation {
    condition     = contains(["none", "ssm", "secretsmanager"], var.private_key_store)
    error_message = "private_key_store must be `none`, `ssm` or `secretsmanager`."
  }
}

variable "private_key_store_name" {
  type        = string
  default     = null
  description = "Name of the SSM parameter (must start with `/`) or Secrets Manager secret holding the private key. Defaults to `/<label id>/ssh-private-key` (SSM) or `<label id>/ssh-private-key` (Secrets Manager)."
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "KMS key ID or ARN used to encrypt the stored private key. Uses the AWS managed key when null; a customer managed key is recommended."
}

variable "secret_recovery_window_in_days" {
  type        = number
  default     = 30
  description = "Recovery window for the Secrets Manager secret in days (`0` deletes immediately, otherwise 7-30)."

  validation {
    condition     = var.secret_recovery_window_in_days == 0 || (var.secret_recovery_window_in_days >= 7 && var.secret_recovery_window_in_days <= 30)
    error_message = "secret_recovery_window_in_days must be 0 or between 7 and 30."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource"
}
