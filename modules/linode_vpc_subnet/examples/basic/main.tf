# Basic usage of the linode_vpc_subnet module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "vpc_subnet" {
  source = "../.."

  vpc_id = 12345
  label  = "test-subnet"
  ipv4   = "10.0.1.0/24"
}
