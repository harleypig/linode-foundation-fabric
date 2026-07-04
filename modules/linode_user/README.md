# Linode User Terraform Module

This module manages a single Linode account user, its account-level (global)
grants, and its per-entity grants (Linodes, Domains, Volumes, Firewalls, and
the rest). Grants only take effect for a `restricted` user.

## Usage

```hcl
module "user" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_user?ref=v2.0.0"

  username = "ci-deployer"
  email    = "ci-deployer@example.com"
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
| [linode_user.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email"></a> [email](#input\_email) | The email of the user. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username of the user. | `string` | n/a | yes |
| <a name="input_domain_grant"></a> [domain\_grant](#input\_domain\_grant) | A set of the user's grants to specific Domains. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_firewall_grant"></a> [firewall\_grant](#input\_firewall\_grant) | A set of the user's grants to specific Firewalls. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_global_grants"></a> [global\_grants](#input\_global\_grants) | A structure containing the Account-level grants a User has. | <pre>object({<br/>    account_access        = optional(string)<br/>    add_databases         = optional(bool)<br/>    add_domains           = optional(bool)<br/>    add_firewalls         = optional(bool)<br/>    add_images            = optional(bool)<br/>    add_linodes           = optional(bool)<br/>    add_longview          = optional(bool)<br/>    add_nodebalancers     = optional(bool)<br/>    add_stackscripts      = optional(bool)<br/>    add_volumes           = optional(bool)<br/>    add_vpcs              = optional(bool)<br/>    cancel_account        = optional(bool)<br/>    longview_subscription = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_image_grant"></a> [image\_grant](#input\_image\_grant) | A set of the user's grants to specific Images. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_linode_grant"></a> [linode\_grant](#input\_linode\_grant) | A set of the user's grants to specific Linodes. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_longview_grant"></a> [longview\_grant](#input\_longview\_grant) | A set of the user's grants to specific Longview clients. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_nodebalancer_grant"></a> [nodebalancer\_grant](#input\_nodebalancer\_grant) | A set of the user's grants to specific NodeBalancers. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_restricted"></a> [restricted](#input\_restricted) | If true, the user must be explicitly granted access to platform actions and entities. | `bool` | `false` | no |
| <a name="input_stackscript_grant"></a> [stackscript\_grant](#input\_stackscript\_grant) | A set of the user's grants to specific StackScripts. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_volume_grant"></a> [volume\_grant](#input\_volume\_grant) | A set of the user's grants to specific Volumes. | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |
| <a name="input_vpc_grant"></a> [vpc\_grant](#input\_vpc\_grant) | A set of the user's grants to specific Virtual Private Clouds (VPCs). | <pre>list(object({<br/>    id          = number<br/>    permissions = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email"></a> [email](#output\_email) | The email of the user. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this user (the username). |
| <a name="output_restricted"></a> [restricted](#output\_restricted) | Whether the user must be explicitly granted access to platform actions and entities. |
| <a name="output_ssh_keys"></a> [ssh\_keys](#output\_ssh\_keys) | SSH keys on the user's profile. |
| <a name="output_tfa_enabled"></a> [tfa\_enabled](#output\_tfa\_enabled) | Whether the user has Two Factor Authentication (TFA) enabled. |
| <a name="output_user_type"></a> [user\_type](#output\_user\_type) | The type of this user. |
| <a name="output_username"></a> [username](#output\_username) | The username of the user. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- Per-entity grants (`linode_grant`, `domain_grant`, …) and non-permissive
  `global_grants` are only enforced when the user is `restricted = true`; an
  unrestricted user has full account access regardless of grants.
- `id` is the username — Linode users are keyed by their username, not a
  numeric id.
- Deleting this resource removes the user from the account; recreate carefully,
  as the user's grants and any pending invitation are lost.
