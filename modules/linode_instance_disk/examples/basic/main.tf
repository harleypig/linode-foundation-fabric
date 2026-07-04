# Basic usage of the linode_instance_disk module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "instance_disk" {
  source = "../.."

  linode_id = 123
  label     = "boot"
  size      = 1024
  image     = "linode/ubuntu22.04"
}
