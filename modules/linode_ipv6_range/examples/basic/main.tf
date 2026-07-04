# Basic usage of the linode_ipv6_range module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "ipv6_range" {
  source = "../.."

  prefix_length = 64
  linode_id     = 12345
}
