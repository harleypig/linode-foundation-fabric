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
| [linode_domain_record.domain_records](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/domain_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_records"></a> [records](#input\_records) | DNS records | <pre>map(object({<br/>    domain_id   = number<br/>    record_type = string<br/>    target      = string<br/>    name        = optional(string)<br/>    ttl_sec     = optional(number)<br/>    priority    = optional(number)<br/>    protocol    = optional(string)<br/>    service     = optional(string)<br/>    tag         = optional(string)<br/>    port        = optional(number)<br/>    weight      = optional(number)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_record_ids"></a> [record\_ids](#output\_record\_ids) | A map of record keys to their respective Linode domain record IDs. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->
