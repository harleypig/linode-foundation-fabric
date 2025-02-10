resource "linode_instance_ip" "this" {
  linode_id        = var.linode_id
  public           = var.public
  rdns             = var.rdns
  apply_immediately = var.apply_immediately
}
