# Linode Reserved IP Assignment Terraform Module

This module assigns an already-reserved IPv4 address to a Linode instance,
wrapping the single `linode_reserved_ip_assignment` resource. The address must
already be reserved on the account before it can be assigned.

## Usage

```hcl
module "reserved_ip_assignment" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_reserved_ip_assignment?ref=v2.0.0"

  address   = "192.0.2.10"
  linode_id = 123456
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
| [linode_reserved_ip_assignment.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/reserved_ip_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address"></a> [address](#input\_address) | The resulting IPv4 address. This must be an already-reserved IPv4 address on the account. | `string` | n/a | yes |
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to allocate an IPv4 address for. | `number` | n/a | yes |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | If true, the instance will be rebooted to update network interfaces. This functionality is not affected by the `skip_implicit_reboots` provider argument. | `bool` | `null` | no |
| <a name="input_public"></a> [public](#input\_public) | Whether the IPv4 address is public or private. | `bool` | `null` | no |
| <a name="input_rdns"></a> [rdns](#input\_rdns) | The reverse DNS assigned to this address. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The resulting IPv4 address. |
| <a name="output_gateway"></a> [gateway](#output\_gateway) | The default gateway for this address. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IPv4 address, which will be the IPv4 address itself. |
| <a name="output_linode_id"></a> [linode\_id](#output\_linode\_id) | The ID of the Linode this IPv4 address is allocated to. |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | The number of bits set in the subnet mask. |
| <a name="output_public"></a> [public](#output\_public) | Whether the IPv4 address is public or private. |
| <a name="output_rdns"></a> [rdns](#output\_rdns) | The reverse DNS assigned to this address. |
| <a name="output_region"></a> [region](#output\_region) | The region this IP resides in. |
| <a name="output_reserved"></a> [reserved](#output\_reserved) | The reservation status of the IP address. |
| <a name="output_subnet_mask"></a> [subnet\_mask](#output\_subnet\_mask) | The mask that separates host bits from network bits for this address. |
| <a name="output_type"></a> [type](#output\_type) | The type of IP address. |
| <a name="output_vpc_nat_1_1"></a> [vpc\_nat\_1\_1](#output\_vpc\_nat\_1\_1) | Contains information about the NAT 1:1 mapping of a public IP address to a VPC subnet. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- The `address` must be an IPv4 address that is **already reserved** on the
  account; this resource assigns an existing reservation to a Linode, it does
  not create the reservation itself.
- Setting `apply_immediately = true` reboots the instance to update its network
  interfaces. This is not affected by the `skip_implicit_reboots` provider
  argument.
- `public` and `apply_immediately` are computed when not set, so leaving them
  `null` defers to the provider/account default.
