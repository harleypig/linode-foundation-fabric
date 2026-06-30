<!-- BEGIN_TF_DOCS -->
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
| [linode_domain.domains](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domains"></a> [domains](#input\_domains) | Domain data. | <pre>map(object({<br/>    domain    = string<br/>    soa_email = string<br/><br/>    description = optional(string)<br/>    expire_sec  = optional(number)<br/>    group       = optional(string)<br/>    refresh_sec = optional(number)<br/>    retry_sec   = optional(number)<br/>    status      = optional(string)<br/>    tags        = optional(list(string))<br/>    ttl_sec     = optional(number)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_ids"></a> [domain\_ids](#output\_domain\_ids) | A map of domain names to their respective Linode domain IDs. |
<!-- END_TF_DOCS -->