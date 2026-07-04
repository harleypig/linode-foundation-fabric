# Basic usage of the linode_domain module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "domain" {
  source = "../.."

  domains = {
    "example.com" = {
      domain      = "example.com"
      soa_email   = "admin@example.com"
      ttl_sec     = 300
      retry_sec   = 300
      expire_sec  = 300
      refresh_sec = 300
    }
  }
}
