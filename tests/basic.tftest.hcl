# Unit tests: no AWS credentials needed, providers are mocked and every run is a plan.
mock_provider "aws" {}
mock_provider "tls" {}

variables {
  name        = "keypair"
  environment = "test"
}

run "generates_key_pair_when_no_public_key" {
  command = plan

  assert {
    condition     = length(tls_private_key.default) == 1 && length(aws_key_pair.default) == 1
    error_message = "A key must be generated and registered when public_key is empty."
  }

  assert {
    condition     = length(aws_ssm_parameter.private_key) == 0 && length(aws_secretsmanager_secret.private_key) == 0
    error_message = "The private key must not be stored anywhere by default."
  }
}

run "imports_supplied_public_key" {
  command = plan

  variables {
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1qrma7SYW/k3kKX23luNNEm6TysKYSYhA3V1dptu7O example@clouddrove\n"
  }

  assert {
    condition     = length(tls_private_key.default) == 0
    error_message = "No key may be generated when a public_key is supplied."
  }

  assert {
    condition     = output.private_key_base64 == ""
    error_message = "There is no private key to output when the public key is imported."
  }

  assert {
    condition     = aws_key_pair.default[0].public_key == "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1qrma7SYW/k3kKX23luNNEm6TysKYSYhA3V1dptu7O example@clouddrove"
    error_message = "The supplied public key must be registered, with surrounding whitespace trimmed."
  }
}

run "disabled_creates_nothing" {
  command = plan

  variables {
    enable_key_pair = false
  }

  assert {
    condition     = length(aws_key_pair.default) == 0 && length(tls_private_key.default) == 0
    error_message = "Nothing may be created when enable_key_pair is false."
  }
}

run "stores_private_key_in_ssm" {
  command = plan

  variables {
    private_key_store = "ssm"
  }

  assert {
    condition     = length(aws_ssm_parameter.private_key) == 1 && length(aws_secretsmanager_secret.private_key) == 0
    error_message = "Only the SSM parameter must be created."
  }
}

run "stores_private_key_in_secretsmanager" {
  command = plan

  variables {
    private_key_store = "secretsmanager"
  }

  assert {
    condition     = length(aws_secretsmanager_secret.private_key) == 1 && length(aws_secretsmanager_secret_version.private_key) == 1 && length(aws_ssm_parameter.private_key) == 0
    error_message = "Only the Secrets Manager secret and its version must be created."
  }
}

run "no_secret_when_key_is_imported" {
  command = plan

  variables {
    private_key_store = "ssm"
    public_key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1qrma7SYW/k3kKX23luNNEm6TysKYSYhA3V1dptu7O example@clouddrove"
  }

  # The module warns (check block) that private_key_store is ignored here; in tests a failed check is an error.
  expect_failures = [check.private_key_store_needs_generated_key]

  assert {
    condition     = length(aws_ssm_parameter.private_key) == 0
    error_message = "There is no private key to store when the public key is imported."
  }
}

run "key_name_prefix_is_used" {
  command = plan

  variables {
    key_name_prefix = "deployer-"
  }

  assert {
    condition     = aws_key_pair.default[0].key_name_prefix == "deployer-"
    error_message = "key_name_prefix must be passed to the key pair."
  }
}

run "rejects_private_key_material" {
  command = plan

  variables {
    public_key = "-----BEGIN OPENSSH PRIVATE KEY-----"
  }

  expect_failures = [var.public_key]
}

run "rejects_unsupported_algorithm" {
  command = plan

  variables {
    private_key_algorithm = "ECDSA"
  }

  expect_failures = [var.private_key_algorithm]
}

run "rejects_conflicting_names" {
  command = plan

  variables {
    key_name        = "a"
    key_name_prefix = "b-"
  }

  expect_failures = [aws_key_pair.default]
}
