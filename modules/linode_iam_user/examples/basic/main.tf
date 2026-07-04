# Basic usage of the linode_iam_user module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "iam_user" {
  source = "../.."

  username = "test-iam-user"

  entity_access = [{
    id    = 123456
    roles = ["linode_viewer"]
    type  = "linode"
  }]
}
