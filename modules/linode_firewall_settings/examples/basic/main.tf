# Basic usage of the linode_firewall_settings module. This example doubles as
# a plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "firewall_settings" {
  source = "../.."

  default_firewall_ids = {
    linode           = 12345
    nodebalancer     = 12346
    public_interface = 12347
    vpc_interface    = 12348
  }
}
