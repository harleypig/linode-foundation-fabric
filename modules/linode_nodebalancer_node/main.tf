resource "linode_nodebalancer_node" "this" {
  nodebalancer_id = var.nodebalancer_id
  config_id       = var.config_id
  address         = var.address
  label           = var.label
  mode            = var.mode
  weight          = var.weight
  subnet_id       = var.subnet_id
}
