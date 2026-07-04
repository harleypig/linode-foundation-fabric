# Linode LKE Node Pool Terraform Module

This module manages a single Linode Kubernetes Engine (LKE) node pool attached
to an existing LKE cluster. It wraps one `linode_lke_node_pool` resource with
optional autoscaling, taints, node labels, and firewall attachment.

## Usage

```hcl
module "lke_node_pool" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_lke_node_pool?ref=v0.2.0"

  cluster_id = 12345
  type       = "g6-standard-1"
  node_count = 3
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
| [linode_lke_node_pool.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lke_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of the cluster to associate this node pool with. | `number` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The type of node pool. | `string` | n/a | yes |
| <a name="input_autoscaler"></a> [autoscaler](#input\_autoscaler) | Autoscaler configuration for the node pool. When set, the pool automatically scales between min and max nodes. | <pre>object({<br/>    min = number<br/>    max = number<br/>  })</pre> | `null` | no |
| <a name="input_disk_encryption"></a> [disk\_encryption](#input\_disk\_encryption) | The disk encryption policy for nodes in this pool. | `string` | `null` | no |
| <a name="input_firewall_id"></a> [firewall\_id](#input\_firewall\_id) | The ID of the Firewall to attach to nodes in this node pool. | `number` | `null` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | The k8s version of the nodes in this node pool. For LKE enterprise only and may not currently be available to all users. | `string` | `null` | no |
| <a name="input_label"></a> [label](#input\_label) | The label of the Node Pool. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Key-value pairs added as labels to nodes in the node pool. Labels help classify your nodes and to easily select subsets of objects. | `map(string)` | `{}` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | The number of nodes in the Node Pool. Leave unset when an autoscaler manages the count. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An array of tags applied to this object. Tags are for organizational purposes only. | `list(string)` | `[]` | no |
| <a name="input_taints"></a> [taints](#input\_taints) | Kubernetes taints to add to node pool nodes. Taints help control how pods are scheduled onto nodes, specifically allowing them to repel certain pods. | <pre>list(object({<br/>    effect = string<br/>    key    = string<br/>    value  = string<br/>  }))</pre> | `[]` | no |
| <a name="input_update_strategy"></a> [update\_strategy](#input\_update\_strategy) | The strategy for updating the node pool k8s version. For LKE enterprise only and may not currently be available to all users. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_disk_encryption"></a> [disk\_encryption](#output\_disk\_encryption) | The disk encryption policy for nodes in this pool. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this Node Pool. |
| <a name="output_k8s_version"></a> [k8s\_version](#output\_k8s\_version) | The k8s version of the nodes in this node pool. |
| <a name="output_label"></a> [label](#output\_label) | The label of the Node Pool. |
| <a name="output_node_count"></a> [node\_count](#output\_node\_count) | The number of nodes in the Node Pool. |
| <a name="output_nodes"></a> [nodes](#output\_nodes) | A list of nodes in the node pool, each with its id, instance\_id, and status. |
| <a name="output_tags"></a> [tags](#output\_tags) | An array of tags applied to this object. |
| <a name="output_type"></a> [type](#output\_type) | The type of node pool. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- The `cluster_id` must reference an existing LKE cluster; this module manages
  only the pool, not the cluster itself.
- Set either `node_count` (a fixed size) or `autoscaler` (a min/max range); the
  autoscaler manages `node_count` when enabled, so it becomes a computed value.
- `k8s_version` and `update_strategy` apply to LKE enterprise only and may not
  be available to all users.
