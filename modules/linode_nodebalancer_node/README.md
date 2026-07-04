# Linode NodeBalancer Node Terraform Module

This module creates and manages a single Linode NodeBalancer node — a backend
(private IP:PORT) attached to a NodeBalancer config that receives balanced
traffic. The caller composes multiple nodes with its own `for_each`.

## Usage

```hcl
module "nodebalancer_node" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_nodebalancer_node?ref=v0.2.0"

  nodebalancer_id = 12345
  config_id       = 67890
  address         = "192.168.1.100:80"
  label           = "web-backend-1"
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
| [linode_nodebalancer_node.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/nodebalancer_node) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address"></a> [address](#input\_address) | The private IP Address and port (IP:PORT) where this backend can be reached. This must be a private IP address. | `string` | n/a | yes |
| <a name="input_config_id"></a> [config\_id](#input\_config\_id) | The ID of the NodeBalancerConfig to access. | `number` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | The label for this node. This is for display purposes only. | `string` | n/a | yes |
| <a name="input_nodebalancer_id"></a> [nodebalancer\_id](#input\_nodebalancer\_id) | The ID of the NodeBalancer to access. | `number` | n/a | yes |
| <a name="input_mode"></a> [mode](#input\_mode) | The mode this NodeBalancer should use when sending traffic to this backend. If set to `accept` this backend is accepting traffic. If set to `reject` this backend will not receive traffic. If set to `drain` this backend will not receive new traffic, but connections already pinned to it will continue to be routed to it. If set to `backup` this backend will only accept traffic if all other nodes are down. | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the VPC subnet for this node. | `number` | `null` | no |
| <a name="input_weight"></a> [weight](#input\_weight) | Used when picking a backend to serve a request and is not pinned to a single backend yet. Nodes with a higher weight will receive more traffic. (1-255) | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | The private IP Address and port (IP:PORT) where this backend can be reached. |
| <a name="output_config_id"></a> [config\_id](#output\_config\_id) | The ID of the NodeBalancerConfig this node serves. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the NodeBalancer node resource. |
| <a name="output_label"></a> [label](#output\_label) | The label for this node. |
| <a name="output_mode"></a> [mode](#output\_mode) | The mode this NodeBalancer uses when sending traffic to this backend. |
| <a name="output_nodebalancer_id"></a> [nodebalancer\_id](#output\_nodebalancer\_id) | The ID of the NodeBalancer this node is attached to. |
| <a name="output_status"></a> [status](#output\_status) | The current status of this node, based on the configured checks of its NodeBalancer Config. (unknown, UP, DOWN) |
| <a name="output_vpc_config_id"></a> [vpc\_config\_id](#output\_vpc\_config\_id) | The ID of the NB-VPC config for this node. |
| <a name="output_weight"></a> [weight](#output\_weight) | The weight used when picking a backend to serve a request. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `address` must be a **private** IP and include the backend port
  (`IP:PORT`); the node and its NodeBalancer must share a region.
- `nodebalancer_id` and `config_id` reference an existing NodeBalancer and
  one of its configs — create those first and pass their IDs (or outputs) in.
- `mode` and `weight` are computed by Linode when omitted; set them only to
  override the defaults.
- `subnet_id` applies only when the node is reached over a VPC subnet.
