# Linode IPv6 Range Terraform Module

This module creates and manages a Linode IPv6 range, assigning a routed /56 or
/64 pool to a Linode instance (via `linode_id`) or to an existing SLAAC address
(via `route_target`).

## Usage

```hcl
module "ipv6_range" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_ipv6_range?ref=v0.2.0"

  prefix_length = 64
  linode_id     = 12345
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
| [linode_ipv6_range.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/ipv6_range) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix_length"></a> [prefix\_length](#input\_prefix\_length) | The prefix length of the IPv6 range. | `number` | n/a | yes |
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to assign this range to. | `number` | `null` | no |
| <a name="input_route_target"></a> [route\_target](#input\_route\_target) | The IPv6 SLAAC address to assign this range to. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The unique ID for this IPv6 range. |
| <a name="output_is_bgp"></a> [is\_bgp](#output\_is\_bgp) | Whether this IPv6 range is shared. |
| <a name="output_linodes"></a> [linodes](#output\_linodes) | A list of Linodes targeted by this IPv6 range, including Linodes with IP sharing. |
| <a name="output_prefix_length"></a> [prefix\_length](#output\_prefix\_length) | The prefix length of the IPv6 range. |
| <a name="output_range"></a> [range](#output\_range) | The IPv6 range of addresses in this pool. |
| <a name="output_region"></a> [region](#output\_region) | The region for this range of IPv6 addresses. |
| <a name="output_route_target"></a> [route\_target](#output\_route\_target) | The IPv6 SLAAC address this range is assigned to. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- Assign the range with **exactly one** of `linode_id` or `route_target`. Set
  `linode_id` to route the pool to a Linode by ID; set `route_target` to route
  it to an existing IPv6 SLAAC address. Leaving `route_target` unset lets the
  provider compute it from the assigned Linode.
- Only prefix lengths of 56 and 64 are supported by the Linode API.
- `region` is derived from the assigned Linode and is exposed as an output, not
  an input.
