# Basic usage of the linode_volume_protected module. This example doubles as
# a plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "volume_protected" {
  source = "../.."

  label  = "test-volume"
  size   = 20
  region = "us-east"
}
