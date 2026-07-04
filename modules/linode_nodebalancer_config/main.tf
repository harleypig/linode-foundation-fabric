resource "linode_nodebalancer_config" "this" {
  nodebalancer_id = var.nodebalancer_id

  port           = var.port
  protocol       = var.protocol
  proxy_protocol = var.proxy_protocol
  algorithm      = var.algorithm
  stickiness     = var.stickiness

  check          = var.check
  check_interval = var.check_interval
  check_timeout  = var.check_timeout
  check_attempts = var.check_attempts
  check_path     = var.check_path
  check_body     = var.check_body
  check_passive  = var.check_passive

  cipher_suite = var.cipher_suite
  ssl_cert     = var.ssl_cert
  ssl_key      = var.ssl_key

  udp_check_port = var.udp_check_port
}
