resource "linode_networking_ip" "this" {
  linode_id = var.linode_id
  public    = var.public
  region    = var.region
  reserved  = var.reserved
  type      = var.type
}
