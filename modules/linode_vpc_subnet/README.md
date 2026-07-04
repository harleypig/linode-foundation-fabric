# Linode VPC Subnet Terraform Module

Manages a single `linode_vpc_subnet` — an IPv4 (and optional IPv6) subnet
within an existing Linode VPC. The caller composes multiple subnets with its
own `for_each`; this module wraps exactly one subnet.

## Usage

```hcl
module "vpc_subnet" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_vpc_subnet?ref=v1.0.0"

  vpc_id = 12345
  label  = "app-subnet"
  ipv4   = "10.0.1.0/24"
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
| [linode_vpc_subnet.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label of the VPC subnet. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of the parent VPC for this VPC Subnet. | `number` | n/a | yes |
| <a name="input_ipv4"></a> [ipv4](#input\_ipv4) | The IPv4 range of this subnet in CIDR format. | `string` | `null` | no |
| <a name="input_ipv6"></a> [ipv6](#input\_ipv6) | The IPv6 ranges of this subnet. Each range is an existing IPv6 prefix owned by the account, or a forward slash (/) followed by a valid prefix length; if unspecified, a range with the default prefix is allocated. | <pre>list(object({<br/>    range = optional(string)<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | The date and time when the VPC Subnet was created. |
| <a name="output_databases"></a> [databases](#output\_databases) | A list of databases currently assigned to this VPC Subnet. |
| <a name="output_id"></a> [id](#output\_id) | The id of the VPC Subnet. |
| <a name="output_ipv4"></a> [ipv4](#output\_ipv4) | The IPv4 range of this subnet in CIDR format. |
| <a name="output_ipv6"></a> [ipv6](#output\_ipv6) | The IPv6 ranges of this subnet, including the computed allocated\_range for each entry. |
| <a name="output_label"></a> [label](#output\_label) | The label of the VPC subnet. |
| <a name="output_linodes"></a> [linodes](#output\_linodes) | A list of Linodes (and their interfaces) currently assigned to this VPC Subnet. |
| <a name="output_nodebalancers"></a> [nodebalancers](#output\_nodebalancers) | A list of NodeBalancers currently assigned to this VPC Subnet. |
| <a name="output_updated"></a> [updated](#output\_updated) | The date and time when the VPC Subnet was updated. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The id of the parent VPC for this VPC Subnet. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- The parent VPC must already exist; pass its id via `vpc_id`. This module
  does not create the VPC.
- `ipv6` is a plugin-framework nested attribute (a list of objects), not a
  legacy block — assign it as an attribute (`ipv6 = [{ range = "/52" }]`), not
  as a nested `ipv6 { ... }` block. Each entry's `allocated_range` is computed
  by Linode and surfaces through the `ipv6` output.
- `label` must be unique within the parent VPC.
