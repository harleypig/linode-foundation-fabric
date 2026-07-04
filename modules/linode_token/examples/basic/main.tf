# Basic usage of the linode_token module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "token" {
  source = "../.."

  label  = "ci-automation"
  scopes = "linodes:read_write domains:read_only"
}
