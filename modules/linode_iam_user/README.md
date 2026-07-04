# Linode IAM User Terraform Module

This module manages a single Linode IAM user's access assignments — the
account-level access and per-entity roles granted to an existing account
username. It does not create the login itself; supply a `username` that
already exists on the account.

## Usage

```hcl
module "iam_user" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_iam_user?ref=v1.0.0"

  username = "test-iam-user"

  entity_access = [{
    id    = 123456
    roles = ["linode_viewer"]
    type  = "linode"
  }]
}
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_iam_user.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/iam_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_username"></a> [username](#input\_username) | The username to work with. | `string` | n/a | yes |
| <a name="input_account_access"></a> [account\_access](#input\_account\_access) | The user account level access. | `list(string)` | `null` | no |
| <a name="input_entity_access"></a> [entity\_access](#input\_entity\_access) | The user entity level access. | <pre>list(object({<br/>    id    = number<br/>    roles = list(string)<br/>    type  = string<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_access"></a> [account\_access](#output\_account\_access) | The user account level access. |
| <a name="output_entity_access"></a> [entity\_access](#output\_entity\_access) | The user entity level access. |
| <a name="output_username"></a> [username](#output\_username) | The username of the IAM user. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `username` must reference an account member that already exists; this module
  assigns access, it does not provision the user.
- `account_access` and `entity_access` are both optional and computed: omit
  them (leave `null`) to let the provider report the account's current
  assignments rather than manage them.
- The provider schema exposes no `id` attribute for this resource — the
  `username` is the identifier — so this module has no `id` output.
- Valid `entity_access.type` values and `account_access` / `roles` names are
  the evolving Linode IAM role catalog; the module validates structure (non-
  empty types/roles, positive entity ids) but does not enum-restrict the role
  strings, to avoid rejecting newly-added Linode roles.
