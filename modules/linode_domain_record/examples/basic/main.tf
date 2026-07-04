# Basic usage of the linode_domain_record module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "domain_record" {
  source = "../.."

  records = {
    www = {
      domain_id   = 123
      record_type = "A"
      target      = "192.0.2.1"
      name        = "www"
      ttl_sec     = 300
    }
  }
}
