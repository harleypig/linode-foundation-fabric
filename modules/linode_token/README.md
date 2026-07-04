# Linode Token Terraform Module

This module manages a single Linode personal access token (an API token
scoped to parts of the account). The generated token value is exposed as a
sensitive output; capture it on creation, as it cannot be retrieved later.

## Usage

```hcl
module "token" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_token?ref=v2.0.0"

  label  = "ci-automation"
  scopes = "linodes:read_write domains:read_only"
}
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_token.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_scopes"></a> [scopes](#input\_scopes) | The scopes this token was created with. These define what parts of the Account the token can be used to access. Many command-line tools, such as the Linode CLI, require tokens with access to *. Tokens with more restrictive scopes are generally more secure. Multiple scopes are separated by a space character (e.g., "databases:read\_only events:read\_only"). | `string` | n/a | yes |
| <a name="input_expiry"></a> [expiry](#input\_expiry) | When this token will expire. Personal Access Tokens cannot be renewed, so after this time the token will be completely unusable and a new token will need to be generated. Tokens may be created with 'null' as their expiry and will never expire unless revoked. Format: 2006-01-02T15:04:05Z | `string` | `null` | no |
| <a name="input_label"></a> [label](#input\_label) | The label of the Linode Token. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | The date and time this token was created. |
| <a name="output_expiry"></a> [expiry](#output\_expiry) | When this token will expire. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the token. |
| <a name="output_label"></a> [label](#output\_label) | The label of the Linode Token. |
| <a name="output_scopes"></a> [scopes](#output\_scopes) | The scopes this token was created with. |
| <a name="output_token"></a> [token](#output\_token) | The token used to access the API. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- The `token` output is **sensitive** and only available at creation time.
  Linode does not return the secret again, so store it immediately (e.g. in a
  secrets manager); losing it means generating a new token.
- Personal access tokens cannot be renewed. Once `expiry` passes the token is
  unusable and a replacement must be generated. Omit `expiry` (leave it null)
  for a token that never expires unless revoked.
- Scopes are space-separated `<resource>:read_only` / `<resource>:read_write`
  entries, or `*` for full access. See the Linode API OAuth reference for the
  full scope list.
