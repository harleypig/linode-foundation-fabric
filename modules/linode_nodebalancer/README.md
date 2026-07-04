# Linode NodeBalancer Terraform Module

This module creates and manages a single Linode NodeBalancer — a managed
layer-4/layer-7 load balancer that distributes traffic across backend nodes.
Backend listeners and nodes are declared separately via the
`linode_nodebalancer_config` and `linode_nodebalancer_node` modules.

## Usage

```hcl
module "nodebalancer" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_nodebalancer?ref=v2.0.0"

  label                = "web-lb"
  region               = "us-east"
  client_conn_throttle = 10
  tags                 = ["web", "production"]
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
| [linode_nodebalancer.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/nodebalancer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_conn_throttle"></a> [client\_conn\_throttle](#input\_client\_conn\_throttle) | Throttle connections per second (0-20). Set to 0 (zero) to disable throttling. | `number` | `null` | no |
| <a name="input_client_udp_sess_throttle"></a> [client\_udp\_sess\_throttle](#input\_client\_udp\_sess\_throttle) | Throttle UDP sessions per second (0-20). Set to 0 (zero) to disable throttling. | `number` | `null` | no |
| <a name="input_firewall_id"></a> [firewall\_id](#input\_firewall\_id) | ID for the firewall you'd like to use with this NodeBalancer. | `number` | `null` | no |
| <a name="input_label"></a> [label](#input\_label) | The label of the Linode NodeBalancer. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where this NodeBalancer will be deployed. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An array of tags applied to this object. Tags are for organizational purposes only. | `list(string)` | `[]` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | A list of VPCs to be assigned to this NodeBalancer. | <pre>list(object({<br/>    subnet_id  = number<br/>    ipv4_range = optional(string)<br/>    ipv6_range = optional(string)<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | When this NodeBalancer was created. |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | This NodeBalancer's hostname, ending with .nodebalancer.linode.com. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of the Linode NodeBalancer. |
| <a name="output_ipv4"></a> [ipv4](#output\_ipv4) | The Public IPv4 Address of this NodeBalancer. |
| <a name="output_ipv6"></a> [ipv6](#output\_ipv6) | The Public IPv6 Address of this NodeBalancer. |
| <a name="output_label"></a> [label](#output\_label) | The label of the Linode NodeBalancer. |
| <a name="output_region"></a> [region](#output\_region) | The region where this NodeBalancer is deployed. |
| <a name="output_tags"></a> [tags](#output\_tags) | An array of tags applied to this object. |
| <a name="output_transfer"></a> [transfer](#output\_transfer) | Information about the amount of transfer this NodeBalancer has had so far this month. |
| <a name="output_updated"></a> [updated](#output\_updated) | When this NodeBalancer was last updated. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- A NodeBalancer only routes traffic once at least one
  `linode_nodebalancer_config` (a listening port + protocol) and its backend
  `linode_nodebalancer_node`s are attached; this module manages the balancer
  itself, not those children.
- `region` is optional in the provider schema but effectively required for a
  new NodeBalancer — set it explicitly so the resource is deployed where you
  expect.
- The write-only `vpcs[*].ipv4_range_auto_assign` attribute is intentionally
  omitted; supply `ipv4_range` / `ipv6_range` (or let the API auto-assign) via
  the `vpcs` input.
