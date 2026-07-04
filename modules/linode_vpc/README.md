# Linode VPC Terraform Module

This module manages a single Linode VPC (a private network isolating a set of
resources within a region). Subnets and interface assignments are declared
separately by the consumer.

## Usage

```hcl
module "vpc" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_vpc?ref=v0.2.0"

  label  = "prod-vpc"
  region = "us-east"
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
| [linode_vpc.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label of the VPC. Only contains ascii letters, digits and dashes | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region of the VPC. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The user-defined description of this VPC. | `string` | `null` | no |
| <a name="input_ipv6"></a> [ipv6](#input\_ipv6) | The IPv6 configuration of this VPC. | <pre>list(object({<br/>    allocation_class = optional(string)<br/>    range            = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | The date and time when the VPC was created. |
| <a name="output_description"></a> [description](#output\_description) | The user-defined description of this VPC. |
| <a name="output_id"></a> [id](#output\_id) | The id of the VPC. |
| <a name="output_ipv6"></a> [ipv6](#output\_ipv6) | The IPv6 configuration of this VPC, including the allocated range. |
| <a name="output_label"></a> [label](#output\_label) | The label of the VPC. |
| <a name="output_region"></a> [region](#output\_region) | The region of the VPC. |
| <a name="output_updated"></a> [updated](#output\_updated) | The date and time when the VPC was updated. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- A VPC is regional: `region` is fixed at creation and cannot be changed in
  place — changing it forces replacement.
- `label` accepts only ASCII letters, digits, and dashes (1-64 characters);
  underscores are rejected, unlike some other Linode resources.
- The `ipv6.allocation_class` argument is write-only (ephemeral): it is sent on
  create but never stored in state or read back. The allocated prefix is
  surfaced through the `ipv6` output's computed `allocated_range`.
