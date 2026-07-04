# Linode Networking IP Terraform Module

This module allocates and manages a single Linode IPv4 address — either a
public/private address attached to a Linode instance, or a reserved address
held at the account or region level.

## Usage

```hcl
module "networking_ip" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_networking_ip?ref=v0.2.0"

  linode_id = 12345
  public    = true
  type      = "ipv4"
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
| [linode_networking_ip.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/networking_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to allocate an IPv4 address for. Required when reserved is false or not set. | `number` | `null` | no |
| <a name="input_public"></a> [public](#input\_public) | Whether the IPv4 address is public or private. | `bool` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region for the reserved IPv4 address. Required when reserved is true and linode\_id is not set. | `string` | `null` | no |
| <a name="input_reserved"></a> [reserved](#input\_reserved) | Whether the IPv4 address should be reserved. | `bool` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of IP address (ipv4). | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The allocated IPv4 address. |
| <a name="output_gateway"></a> [gateway](#output\_gateway) | The default gateway for this address. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IPv4 address. |
| <a name="output_linode_id"></a> [linode\_id](#output\_linode\_id) | The ID of the Linode this IPv4 address is allocated for. |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | The number of bits set in the subnet mask. |
| <a name="output_public"></a> [public](#output\_public) | Whether the IPv4 address is public or private. |
| <a name="output_rdns"></a> [rdns](#output\_rdns) | The reverse DNS assigned to this address. For public IPv4 addresses, this will be set to a default value provided by Linode. |
| <a name="output_region"></a> [region](#output\_region) | The region of the reserved IPv4 address. |
| <a name="output_reserved"></a> [reserved](#output\_reserved) | Whether the IPv4 address is reserved. |
| <a name="output_subnet_mask"></a> [subnet\_mask](#output\_subnet\_mask) | The mask that separates host bits from network bits for this address. |
| <a name="output_type"></a> [type](#output\_type) | The type of IP address (ipv4). |
| <a name="output_vpc_nat_1_1"></a> [vpc\_nat\_1\_1](#output\_vpc\_nat\_1\_1) | Information about the NAT 1:1 mapping of a public IP address to a VPC subnet. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- Provider constraints on required fields are runtime, not plan-time:
  `linode_id` is required when `reserved` is `false` or unset, and `region` is
  required when `reserved` is `true` and `linode_id` is not set. The module
  does not cross-validate these — the provider enforces them at apply.
- `type` accepts only `ipv4`; this resource does not allocate IPv6 addresses.
- `address`, `gateway`, `prefix`, `rdns`, `subnet_mask`, and `vpc_nat_1_1` are
  computed by Linode and exposed as outputs.
