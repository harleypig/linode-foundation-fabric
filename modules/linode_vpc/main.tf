resource "linode_vpc" "this" {
  label       = var.label
  region      = var.region
  description = var.description
  ipv6        = var.ipv6
}
