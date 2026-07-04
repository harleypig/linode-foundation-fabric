resource "linode_interface" "this" {
  linode_id   = var.linode_id
  firewall_id = var.firewall_id

  default_route = var.default_route
  public        = var.public
  vlan          = var.vlan
  vpc           = var.vpc
}
