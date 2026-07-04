resource "linode_nodebalancer" "this" {
  label  = var.label
  region = var.region

  client_conn_throttle     = var.client_conn_throttle
  client_udp_sess_throttle = var.client_udp_sess_throttle

  firewall_id = var.firewall_id
  tags        = var.tags

  vpcs = var.vpcs
}
