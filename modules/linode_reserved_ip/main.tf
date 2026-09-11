resource "linode_reserved_ip" "this" {
  region = var.region
  tags   = var.tags
}
