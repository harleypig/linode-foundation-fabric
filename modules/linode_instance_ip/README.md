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
| [linode_instance_ip.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to allocate an IPv4 address for. | `number` | n/a | yes |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | If true, the instance will be rebooted to update network interfaces. | `bool` | `false` | no |
| <a name="input_public"></a> [public](#input\_public) | Whether the IPv4 address is public or private. Defaults to true. | `bool` | `true` | no |
| <a name="input_rdns"></a> [rdns](#input\_rdns) | The reverse DNS assigned to this address. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The resulting IPv4 address. |
| <a name="output_gateway"></a> [gateway](#output\_gateway) | The default gateway for this address |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | The number of bits set in the subnet mask. |
| <a name="output_region"></a> [region](#output\_region) | The region this IP resides in. |
| <a name="output_subnet_mask"></a> [subnet\_mask](#output\_subnet\_mask) | The mask that separates host bits from network bits for this address. |
| <a name="output_type"></a> [type](#output\_type) | The type of IP address. (ipv4, ipv6, ipv6/pool, ipv6/range) |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->
