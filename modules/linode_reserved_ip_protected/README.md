# Linode Reserved IP (Protected) Terraform Module

The `prevent_destroy` variant of
[`../linode_reserved_ip`](../linode_reserved_ip). It is identical to the base module in every input, output, and resource. The
only difference is a `lifecycle { prevent_destroy = true }` guard on the
reservation, so Terraform **refuses to destroy or replace it** and errors on
any plan that would. Use it for an address that must survive: one that DNS
points at, or that an instance is created on.

## Usage

```hcl
module "reserved_ip" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_reserved_ip_protected?ref=v2.2.0"

  region = "us-east"
  tags   = ["prod", "web"]
}
```

## Why a separate module

Terraform requires the `prevent_destroy` meta-argument to be a **literal**; a
variable cannot set it, so one shared module cannot toggle protection per
instance. A distinct module is the only way to express "this reservation is
protected, that one is not". Keep `variables.tf`, `outputs.tf`, and
`provider.tf` byte-identical to `../linode_reserved_ip` (a `diff` should be
empty); only `main.tf` is meant to differ.

## Protecting an existing reservation (state move)

Switching a reservation that already exists in state from
`linode_reserved_ip` to this module changes its resource address, which
Terraform otherwise reads as destroy-and-recreate, and that would release the
address. Add a `moved` block in the consuming configuration:

```hcl
moved {
  from = module.reserved_ip.linode_reserved_ip.this
  to   = module.reserved_ip_protected.linode_reserved_ip.this
}
```

For a module called with `for_each`, give the instance key on both sides
(`module.reserved_ip["web"].linode_reserved_ip.this`). Confirm with
`terraform plan` that the result is a move with **0 to destroy** before
applying.

## Checking the guard

The plan-only tests cannot reach `prevent_destroy`, which acts only on a
destroy or replace. To see it work without touching an account, plan a
destroy against a state that holds the reservation, with `-refresh=false` so
the provider makes no API call: the base module plans `1 to destroy`, this
module fails with `Error: Instance cannot be destroyed`. Changing `region`
(which forces replacement) fails the same way.

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

- Removing the module call, or a plan that would replace the reservation,
  fails while the guard is in place. To release the address on purpose, move
  it back to `linode_reserved_ip` with a `moved` block first.
- See [`../linode_reserved_ip`](../linode_reserved_ip) for the computed
  outputs and the `region` replacement behaviour; they are shared.
