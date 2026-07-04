# Basic usage of the linode_placement_group_assignment module. This example
# doubles as a plan-only test fixture: tests/validations.tftest.hcl plans it
# under a mock provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "placement_group_assignment" {
  source = "../.."

  placement_group_id = 12345
  linode_id          = 67890
}
