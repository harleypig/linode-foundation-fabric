# Basic usage of the linode_account_settings module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "account_settings" {
  source = "../.."

  backups_enabled            = true
  network_helper             = true
  interfaces_for_new_linodes = "linode_only"
  maintenance_policy         = "linode/migrate"
}
