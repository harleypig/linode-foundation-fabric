# Linode Database Access Controls Terraform Module

This module manages the allow list for a single Linode Managed Database — the
set of IP addresses and CIDR ranges permitted to connect to it. The database
itself must already exist; this resource governs only its network access.

## Usage

```hcl
module "database_access_controls" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_database_access_controls?ref=v0.2.0"

  database_id   = 12345
  database_type = "mysql"
  allow_list    = ["203.0.113.1", "192.168.1.0/24"]
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
| [linode_database_access_controls.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/database_access_controls) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_list"></a> [allow\_list](#input\_allow\_list) | A list of IP addresses that can access the Managed Database. Each item can be a single IP address or a range in CIDR format. | `set(string)` | n/a | yes |
| <a name="input_database_id"></a> [database\_id](#input\_database\_id) | The ID of the database to manage the allow list for. | `number` | n/a | yes |
| <a name="input_database_type"></a> [database\_type](#input\_database\_type) | The type of the database to manage the allow list for. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allow_list"></a> [allow\_list](#output\_allow\_list) | The list of IP addresses and CIDR ranges permitted to access the Managed Database. |
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The ID of the database the allow list is managed for. |
| <a name="output_database_type"></a> [database\_type](#output\_database\_type) | The type of the database the allow list is managed for. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this database access controls resource. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `database_type` accepts the currently supported Managed Database engines,
  `mysql` and `postgresql`. Legacy engines (mongodb, redis) are no longer
  offered and are rejected by the input validation.
- The `allow_list` fully replaces the database's existing allow list on each
  apply — it is authoritative, not additive.
- Each `allow_list` entry is a single IP address or a range in CIDR format;
  an empty list is rejected because it would block all access.
