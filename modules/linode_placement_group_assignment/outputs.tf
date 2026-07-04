output "id" {
  description = "The unique ID that represents the assignment between a Placement Group and a set of Linodes."
  value       = linode_placement_group_assignment.this.id
}
