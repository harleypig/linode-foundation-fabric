# Basic usage of the linode_networking_ip_assignment module. This example
# doubles as a plan-only test fixture: tests/validations.tftest.hcl plans it
# under a mock provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "networking_ip_assignment" {
  source = "../.."

  region = "us-east"

  assignments = [{
    address   = "192.0.2.10"
    linode_id = 12345
  }]
}
