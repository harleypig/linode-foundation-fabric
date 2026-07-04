# Linode LKE Cluster Terraform Module

This module creates and manages a single Linode Kubernetes Engine (LKE)
cluster, wrapping the `linode_lke_cluster` resource with its node pools,
control-plane settings, and optional VPC/ACL configuration.

## Usage

```hcl
module "lke_cluster" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_lke_cluster?ref=v2.0.0"

  label       = "prod-cluster"
  region      = "us-east"
  k8s_version = "1.32"

  pool = [
    {
      type  = "g6-standard-2"
      count = 3
    }
  ]
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
| [linode_lke_cluster.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lke_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | The desired Kubernetes version for this Kubernetes cluster in the format of <major>.<minor>. The latest supported patch version will be deployed. | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | The unique label for the cluster. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | This cluster's location. | `string` | n/a | yes |
| <a name="input_apl_enabled"></a> [apl\_enabled](#input\_apl\_enabled) | Enables the App Platform Layer for this cluster. Note: v4beta only and may not currently be available to all users. | `bool` | `null` | no |
| <a name="input_control_plane"></a> [control\_plane](#input\_control\_plane) | Defines settings for the Kubernetes Control Plane, including High Availability and an optional API-server access-control list. | <pre>object({<br/>    audit_logs_enabled = optional(bool)<br/>    high_availability  = optional(bool)<br/>    acl = optional(object({<br/>      enabled = optional(bool)<br/>      addresses = optional(object({<br/>        ipv4 = optional(set(string))<br/>        ipv6 = optional(set(string))<br/>      }))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_external_pool_tags"></a> [external\_pool\_tags](#input\_external\_pool\_tags) | An array of tags indicating that node pools having those tags are defined with a separate nodepool resource, rather than inside the current cluster resource. | `set(string)` | `[]` | no |
| <a name="input_pool"></a> [pool](#input\_pool) | The node pools in the cluster. At least one pool is required for standard tier clusters. | <pre>list(object({<br/>    type            = string<br/>    count           = optional(number)<br/>    disk_encryption = optional(string)<br/>    firewall_id     = optional(number)<br/>    k8s_version     = optional(string)<br/>    label           = optional(string)<br/>    labels          = optional(map(string))<br/>    tags            = optional(set(string))<br/>    update_strategy = optional(string)<br/>    autoscaler = optional(object({<br/>      min = number<br/>      max = number<br/>    }))<br/>    taint = optional(set(object({<br/>      effect = string<br/>      key    = string<br/>      value  = string<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_stack_type"></a> [stack\_type](#input\_stack\_type) | The networking stack type of the Kubernetes cluster. | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the VPC subnet to use for the Kubernetes cluster. This subnet must be dual stack (IPv4 and IPv6 should both be enabled). | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An array of tags applied to this object. Tags are for organizational purposes only. | `list(string)` | `[]` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | The desired Kubernetes tier. | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | The timeouts configuration for the Linode LKE cluster. | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to use for the Kubernetes cluster. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_endpoints"></a> [api\_endpoints](#output\_api\_endpoints) | The API endpoints for the cluster. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this LKE cluster. |
| <a name="output_k8s_version"></a> [k8s\_version](#output\_k8s\_version) | The Kubernetes version deployed for this cluster. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | The Base64-encoded Kubeconfig for the cluster. |
| <a name="output_label"></a> [label](#output\_label) | The unique label for the cluster. |
| <a name="output_pool"></a> [pool](#output\_pool) | The node pools in the cluster, including computed node details. |
| <a name="output_region"></a> [region](#output\_region) | This cluster's location. |
| <a name="output_stack_type"></a> [stack\_type](#output\_stack\_type) | The networking stack type of the Kubernetes cluster. |
| <a name="output_status"></a> [status](#output\_status) | The status of the cluster. |
| <a name="output_tier"></a> [tier](#output\_tier) | The Kubernetes tier of the cluster. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- At least one `pool` is required for standard-tier clusters; enterprise-tier
  clusters may define pools separately and reference them via
  `external_pool_tags`.
- `kubeconfig` is a sensitive, computed output (Base64-encoded); consume it
  with care and never commit it.
- Reducing a pool's `count` deletes nodes; when an `autoscaler` is set, the
  pool size is managed within its `min`/`max` bounds instead of by `count`.
- `apl_enabled`, enterprise `tier`, and per-pool `k8s_version` /
  `update_strategy` are newer/v4beta features that may not be available to all
  accounts.
