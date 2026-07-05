# Basic usage of the linode_lock module. This example doubles as a plan-only
# test fixture: tests/validations.tftest.hcl plans it under a mock provider to
# prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "lock" {
  source = "../.."

  entity_id   = 123456
  entity_type = "volume"
  lock_type   = "cannot_delete_with_subresources"
}
