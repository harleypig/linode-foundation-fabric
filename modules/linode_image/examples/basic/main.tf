# Basic usage of the linode_image module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "image" {
  source = "../.."

  label     = "example-image"
  linode_id = 12345
  disk_id   = 67890
  tags      = ["example"]
}
