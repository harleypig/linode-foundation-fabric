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
| [linode_rdns.rdns](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/rdns) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rdns"></a> [rdns](#input\_rdns) | Reverse DNS entries | <pre>map(object({<br>    address = string<br>    rdns    = string<br>    wait    = optional(bool)<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->