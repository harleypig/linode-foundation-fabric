output "id" {
  description = "The unique ID of this Placement Group."
  value       = linode_placement_group.this.id
}

output "label" {
  description = "The label of the Placement Group."
  value       = linode_placement_group.this.label
}

output "region" {
  description = "The region of the Placement Group."
  value       = linode_placement_group.this.region
}

output "placement_group_type" {
  description = "The placement group type for Linodes in this Placement Group."
  value       = linode_placement_group.this.placement_group_type
}

output "placement_group_policy" {
  description = "Whether this Placement Group has a strict compliance policy."
  value       = linode_placement_group.this.placement_group_policy
}

output "is_compliant" {
  description = "Whether all Linodes in this Placement Group are currently compliant."
  value       = linode_placement_group.this.is_compliant
}

output "members" {
  description = "A set of Linodes currently assigned to this Placement Group."
  value       = linode_placement_group.this.members
}
