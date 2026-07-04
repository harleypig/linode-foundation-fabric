# Linode Placement Group Assignment Terraform Module

This module manages a single assignment of a Linode to a Placement Group. It
wraps one `linode_placement_group_assignment` resource; the caller composes
multiple assignments with its own `for_each`.

## Usage

```hcl
module "placement_group_assignment" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_placement_group_assignment?ref=v1.0.0"

  placement_group_id = 12345
  linode_id          = 67890
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
| [linode_placement_group_assignment.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/placement_group_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | A set of Linode IDs to assign to the Placement Group. | `number` | n/a | yes |
| <a name="input_placement_group_id"></a> [placement\_group\_id](#input\_placement\_group\_id) | The ID of the Placement Group for this assignment. | `number` | n/a | yes |
| <a name="input_compliant_only"></a> [compliant\_only](#input\_compliant\_only) | When enabled, only Linodes that are compliant with the Placement Group's affinity policy are assigned. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The unique ID that represents the assignment between a Placement Group and a set of Linodes. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- The assignment is the join between an existing Placement Group and an
  existing Linode; create both before assigning.
- `compliant_only`, when set, restricts the assignment to Linodes compliant
  with the Placement Group's affinity policy.
- A Linode can belong to at most one Placement Group at a time.
