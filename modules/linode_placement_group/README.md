# Linode Placement Group Terraform Module

This module manages a single Linode Placement Group — an availability grouping
that controls how the Linodes assigned to it are physically placed within a
region (for example, spreading them across hosts via an anti-affinity policy).

## Usage

```hcl
module "placement_group" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_placement_group?ref=v1.0.0"

  label                = "web-tier-anti-affinity"
  region               = "us-east"
  placement_group_type = "anti_affinity:local"
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
| [linode_placement_group.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/placement_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label of the Placement Group. | `string` | n/a | yes |
| <a name="input_placement_group_type"></a> [placement\_group\_type](#input\_placement\_group\_type) | The placement group type for Linodes in this Placement Group. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region of the Placement Group. | `string` | n/a | yes |
| <a name="input_placement_group_policy"></a> [placement\_group\_policy](#input\_placement\_group\_policy) | Whether this Placement Group has a strict compliance policy. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this Placement Group. |
| <a name="output_is_compliant"></a> [is\_compliant](#output\_is\_compliant) | Whether all Linodes in this Placement Group are currently compliant. |
| <a name="output_label"></a> [label](#output\_label) | The label of the Placement Group. |
| <a name="output_members"></a> [members](#output\_members) | A set of Linodes currently assigned to this Placement Group. |
| <a name="output_placement_group_policy"></a> [placement\_group\_policy](#output\_placement\_group\_policy) | Whether this Placement Group has a strict compliance policy. |
| <a name="output_placement_group_type"></a> [placement\_group\_type](#output\_placement\_group\_type) | The placement group type for Linodes in this Placement Group. |
| <a name="output_region"></a> [region](#output\_region) | The region of the Placement Group. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `placement_group_type` is currently limited to `anti_affinity:local`, which
  spreads member Linodes across separate physical hosts within the region.
- `placement_group_policy` (`strict` or `flexible`) governs whether new members
  may be assigned when the group cannot remain fully compliant; it is
  provider-computed when omitted.
- Member Linodes are attached to the group elsewhere (on the instance or via
  the placement-group assignment resource); this module only manages the group
  itself. The computed `members` and `is_compliant` outputs reflect that state.
- Label must be unique within your Linode account and cannot be changed to a
  region-incompatible value after creation.
