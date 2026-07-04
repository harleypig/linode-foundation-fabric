# Basic usage of the linode_instance_shared_ips module. This example doubles
# as a plan-only test fixture: tests/validations.tftest.hcl plans it under a
# mock provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "instance_shared_ips" {
  source = "../.."

  linode_id = 12345
  addresses = [
    "192.0.2.10",
    "2600:3c00::f03c:0:0:1",
  ]
}
