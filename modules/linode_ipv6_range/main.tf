resource "linode_ipv6_range" "this" {
  prefix_length = var.prefix_length
  linode_id     = var.linode_id
  route_target  = var.route_target
}
