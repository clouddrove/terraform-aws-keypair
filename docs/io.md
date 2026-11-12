## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`). | `list(string)` | `[]` | no |
| enable\_key\_pair | A boolean flag to enable/disable key pair. | `bool` | `true` | no |
| enable\_private\_key | DEPRECATED and ignored. A key pair is now generated automatically whenever `public_key` is empty. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| key\_name | Name of the EC2 key pair. Defaults to `<label id>-pair`. Conflicts with `key_name_prefix`. | `string` | `null` | no |
| key\_name\_prefix | Creates a unique key pair name beginning with this prefix. Conflicts with `key_name`. | `string` | `null` | no |
| kms\_key\_id | KMS key ID or ARN used to encrypt the stored private key. Uses the AWS managed key when null; a customer managed key is recommended. | `string` | `null` | no |
| label\_order | label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| private\_key\_algorithm | Algorithm used when generating the key pair. Supported values are `RSA` and `ED25519` (the algorithms EC2 accepts). ED25519 is recommended for new keys but is not supported on Windows instances. | `string` | `"RSA"` | no |
| private\_key\_rsa\_bits | When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`) | `number` | `4096` | no |
| private\_key\_store | Where to keep a generated private key: `none` (state only), `ssm` (SSM Parameter Store SecureString) or `secretsmanager` (AWS Secrets Manager). Only used when the module generates the key. | `string` | `"none"` | no |
| private\_key\_store\_name | Name of the SSM parameter (must start with `/`) or Secrets Manager secret holding the private key. Defaults to `/<label id>/ssh-private-key` (SSM) or `<label id>/ssh-private-key` (Secrets Manager). | `string` | `null` | no |
| public\_key | OpenSSH public key to import into AWS (e.g. `ssh-ed25519 AAAAC3...`). Leave empty to have the module generate a key pair automatically. Never pass a private key here. | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-keypair"` | no |
| secret\_recovery\_window\_in\_days | Recovery window for the Secrets Manager secret in days (`0` deletes immediately, otherwise 7-30). | `number` | `30` | no |
| tags | A map of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The key pair ARN. |
| fingerprint | The fingerprint of the key pair as reported by AWS. |
| id | The key pair name. |
| key\_pair\_id | The key pair ID (e.g. `key-0123456789abcdef0`). |
| name | Name of SSH key. |
| private\_key\_base64 | Base64 encoded OpenSSH private key of the generated key pair (empty when a public_key is supplied). Base64 is encoding, not encryption: the key is also in the Terraform state, so protect the state. Decode with `terraform output -raw private_key_base64 | base64 -d`. |
| private\_key\_id | Unique identifier for the generated key: hexadecimal representation of the SHA1 checksum of the resource. Empty when a public_key is supplied. |
| private\_key\_secret\_arn | ARN of the SSM parameter or Secrets Manager secret holding the generated private key. Null unless private_key_store is `ssm` or `secretsmanager`. |
| private\_key\_secret\_name | Name of the SSM parameter or Secrets Manager secret holding the generated private key. Null unless private_key_store is `ssm` or `secretsmanager`. |
| public\_key\_fingerprint\_sha256 | SHA256 fingerprint of the generated public key (e.g. `SHA256:...`). Empty when a public_key is supplied. |
| public\_key\_openssh | The public key registered in AWS, in "Authorized Keys" format (generated or supplied). |
| public\_key\_pem | Public key data in PEM (RFC 1421) format. Empty when a public_key is supplied. |
