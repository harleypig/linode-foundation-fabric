# Linode Reserved IP Terraform Module

This module reserves a single Linode IPv4 address in a region, wrapping the
`linode_reserved_ip` resource. The address is not attached to a Linode until
a separate assignment (see `linode_reserved_ip_assignment`) puts it there.

## Usage

```hcl
module "reserved_ip" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_reserved_ip?ref=v2.0.0"

  region = "us-east"
  tags   = ["prod", "web"]
}
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_reserved_ip.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/reserved_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The region in which to reserve the IP address. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to this reserved IP address. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The reserved IPv4 address. |
| <a name="output_assigned_entity"></a> [assigned\_entity](#output\_assigned\_entity) | The entity this reserved IP address is currently assigned to, if any. |
| <a name="output_gateway"></a> [gateway](#output\_gateway) | The default gateway for this address. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the reserved IP address, which is the address itself. |
| <a name="output_linode_id"></a> [linode\_id](#output\_linode\_id) | The ID of the Linode this address is currently assigned to, if any. |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | The number of bits set in the subnet mask. |
| <a name="output_public"></a> [public](#output\_public) | Whether this is a public or private IP address. |
| <a name="output_rdns"></a> [rdns](#output\_rdns) | The reverse DNS assigned to this address. |
| <a name="output_reserved"></a> [reserved](#output\_reserved) | Whether this IP address is reserved. |
| <a name="output_subnet_mask"></a> [subnet\_mask](#output\_subnet\_mask) | The mask that separates host bits from network bits for this address. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags applied to this reserved IP address. |
| <a name="output_type"></a> [type](#output\_type) | The type of IP address. |
| <a name="output_vpc_nat_1_1"></a> [vpc\_nat\_1\_1](#output\_vpc\_nat\_1\_1) | Information about the NAT 1:1 mapping of this address to a VPC subnet. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `region` is set at creation and cannot be changed in place — changing it
  forces the reservation to be replaced.
- `address`, `gateway`, `subnet_mask`, `prefix`, `type`, `public`, `rdns`,
  `linode_id`, `reserved`, `vpc_nat_1_1`, and `assigned_entity` are computed
  by Linode and exposed as outputs; `linode_id` and `assigned_entity` are set
  only once the reservation has been assigned to a Linode.
