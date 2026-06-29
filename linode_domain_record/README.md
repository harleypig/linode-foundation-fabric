<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | n/a |

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

No outputs.
<!-- END_TF_DOCS -->