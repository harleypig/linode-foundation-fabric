# Basic usage of the linode_nodebalancer_node module. This example doubles as
# a plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "nodebalancer_node" {
  source = "../.."

  nodebalancer_id = 12345
  config_id       = 67890
  address         = "192.168.1.100:80"
  label           = "web-backend-1"
  mode            = "accept"
  weight          = 50
}
