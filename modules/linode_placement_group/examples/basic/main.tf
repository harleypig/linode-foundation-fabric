# Basic usage of the linode_placement_group module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "placement_group" {
  source = "../.."

  label                = "test-placement-group"
  region               = "us-east"
  placement_group_type = "anti_affinity:local"
}
