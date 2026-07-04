# Basic usage of the linode_nodebalancer_config module. This example doubles
# as a plan-only test fixture: tests/validations.tftest.hcl plans it under a
# mock provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "nodebalancer_config" {
  source = "../.."

  nodebalancer_id = 12345

  port      = 80
  protocol  = "http"
  algorithm = "roundrobin"

  check          = "http"
  check_path     = "/"
  check_interval = 30
  check_timeout  = 5
  check_attempts = 3
}
