# Basic usage of the linode_lke_node_pool module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "lke_node_pool" {
  source = "../.."

  cluster_id = 12345
  type       = "g6-standard-1"
  node_count = 3
}
