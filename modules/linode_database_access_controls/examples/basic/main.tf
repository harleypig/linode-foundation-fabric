# Basic usage of the linode_database_access_controls module. This example
# doubles as a plan-only test fixture: tests/validations.tftest.hcl plans it
# under a mock provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "database_access_controls" {
  source = "../.."

  database_id   = 12345
  database_type = "mysql"
  allow_list    = ["203.0.113.1", "192.168.1.0/24"]
}
