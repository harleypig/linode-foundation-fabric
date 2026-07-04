resource "linode_placement_group_assignment" "this" {
  placement_group_id = var.placement_group_id
  linode_id          = var.linode_id
  compliant_only     = var.compliant_only
}
