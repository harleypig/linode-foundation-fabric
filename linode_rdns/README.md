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
| [linode_rdns.rdns](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/rdns) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rdns"></a> [rdns](#input\_rdns) | Reverse DNS entries | <pre>map(object({<br/>    address = string<br/>    rdns    = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rdns_ids"></a> [rdns\_ids](#output\_rdns\_ids) | A map of RDNS keys to their respective Linode RDNS record IDs. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->