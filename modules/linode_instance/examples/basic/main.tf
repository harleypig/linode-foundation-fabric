# Basic usage of the linode_instance module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "instance" {
  source = "../.."

  region = "us-central"
  type   = "g6-standard-1"
  image  = "linode/ubuntu22.04"
}
