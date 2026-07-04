resource "linode_instance_shared_ips" "this" {
  linode_id = var.linode_id
  addresses = var.addresses
}
