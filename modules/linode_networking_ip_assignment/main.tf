resource "linode_networking_ip_assignment" "this" {
  region      = var.region
  assignments = var.assignments
}
