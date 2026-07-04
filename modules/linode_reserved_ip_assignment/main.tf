resource "linode_reserved_ip_assignment" "this" {
  address           = var.address
  linode_id         = var.linode_id
  apply_immediately = var.apply_immediately
  public            = var.public
  rdns              = var.rdns
}
