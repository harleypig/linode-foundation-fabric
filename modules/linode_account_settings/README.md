# Linode Account Settings Terraform Module

This module manages the account-wide default settings for a Linode account —
backups default, network helper, the interface mode for new Linodes, and the
default maintenance policy. There is exactly one settings object per account,
so a Linode account should have at most one instance of this resource.

## Usage

```hcl
module "account_settings" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_account_settings?ref=v2.0.0"

  backups_enabled            = true
  network_helper             = true
  interfaces_for_new_linodes = "linode_only"
  maintenance_policy         = "linode/migrate"
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
| [linode_account_settings.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/account_settings) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backups_enabled"></a> [backups\_enabled](#input\_backups\_enabled) | Account-wide backups default. | `bool` | `null` | no |
| <a name="input_interfaces_for_new_linodes"></a> [interfaces\_for\_new\_linodes](#input\_interfaces\_for\_new\_linodes) | Type of interfaces for new Linode instances. | `string` | `null` | no |
| <a name="input_maintenance_policy"></a> [maintenance\_policy](#input\_maintenance\_policy) | The default Maintenance Policy for this account. If not provided, the default policy (linode/migrate) will be applied. | `string` | `null` | no |
| <a name="input_network_helper"></a> [network\_helper](#input\_network\_helper) | Enables network helper across all users by default for new Linodes and Linode Configs. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backups_enabled"></a> [backups\_enabled](#output\_backups\_enabled) | Account-wide backups default. |
| <a name="output_id"></a> [id](#output\_id) | The email of the current account. |
| <a name="output_interfaces_for_new_linodes"></a> [interfaces\_for\_new\_linodes](#output\_interfaces\_for\_new\_linodes) | Type of interfaces for new Linode instances. |
| <a name="output_longview_subscription"></a> [longview\_subscription](#output\_longview\_subscription) | The Longview Pro tier you are currently subscribed to. |
| <a name="output_maintenance_policy"></a> [maintenance\_policy](#output\_maintenance\_policy) | The default Maintenance Policy for this account. |
| <a name="output_managed"></a> [managed](#output\_managed) | Whether monitoring for connectivity, response, and total request time is enabled. |
| <a name="output_network_helper"></a> [network\_helper](#output\_network\_helper) | Whether network helper is enabled across all users by default for new Linodes and Linode Configs. |
| <a name="output_object_storage"></a> [object\_storage](#output\_object\_storage) | A string describing the status of this account's Object Storage service enrollment. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- This is a **singleton** resource: there is one settings object per Linode
  account. Do not declare more than one instance against the same account.
- Every argument is optional; an omitted argument leaves the current
  account-wide value untouched (the provider reads it back as a computed
  result).
- `longview_subscription`, `managed`, and `object_storage` are read-only
  results exposed as outputs; they cannot be set through this resource.
- `maintenance_policy` defaults to `linode/migrate` when unset.
