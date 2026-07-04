# Basic usage of the linode_rdns module. This example doubles as a plan-only
# test fixture: tests/validations.tftest.hcl plans it under a mock provider
# to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "rdns" {
  source = "../.."

  rdns = {
    web = {
      address = "192.0.2.10"
      rdns    = "web.example.com"
    }
  }
}
