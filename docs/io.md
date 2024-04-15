## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`). | `list(string)` | `[]` | no |
| enable\_key\_pair | A boolean flag to enable/disable key pair. | `bool` | `true` | no |
| enable\_private\_key | Determines whether a private key will be created | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| label\_order | label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| private\_key\_algorithm | Name of the algorithm to use when generating the private key. Currently-supported values are `RSA` and `ED25519` | `string` | `"RSA"` | no |
| private\_key\_rsa\_bits | When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`) | `number` | `4096` | no |
| public\_key | Name  (e.g. `ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQ`). | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-keypair"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The key pair ARN. |
| id | The key pair name. |
| name | Name of SSH key. |
| private\_key\_id | Unique identifier for this resource: hexadecimal representation of the SHA1 checksum of the resource |
| public\_key\_openssh | The public key data in "Authorized Keys" format. This is populated only if the configured private key is supported: this includes all `RSA` and `ED25519` keys |
| public\_key\_pem | Public key data in PEM (RFC 1421) format |

