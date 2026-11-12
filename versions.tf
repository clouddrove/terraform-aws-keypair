# Terraform version
terraform {
  # >= 1.11 is required for write-only arguments (value_wo / secret_string_wo).
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # tf-skill:ignore TF-PROV-001 -- published reusable module: lower bound plus major cap instead of ~> so consumers are not pinned to one minor
      version = ">= 5.100.0, < 7.0.0"
    }
    tls = {
      source = "hashicorp/tls"
      # tf-skill:ignore TF-PROV-001 -- published reusable module: lower bound plus major cap instead of ~>
      version = ">= 4.0.0, < 5.0.0"
    }
  }

  provider_meta "aws" {
    user_agent = ["github.com/clouddrove/terraform-aws-keypair"]
  }
}
