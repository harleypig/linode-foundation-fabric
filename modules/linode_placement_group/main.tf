resource "linode_placement_group" "this" {
  label                  = var.label
  region                 = var.region
  placement_group_type   = var.placement_group_type
  placement_group_policy = var.placement_group_policy
}
