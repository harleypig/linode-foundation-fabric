# Basic usage of the linode_database_mysql_v2 module. This example doubles as
# a plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "database_mysql_v2" {
  source = "../.."

  label     = "example-mysql-db"
  engine_id = "mysql/8"
  region    = "us-east"
  type      = "g6-nanode-1"
}
