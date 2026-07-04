# Basic usage of the linode_nodebalancer module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "nodebalancer" {
  source = "../.."

  label                = "test-nodebalancer"
  region               = "us-east"
  client_conn_throttle = 10
  tags                 = ["web", "production"]
}
