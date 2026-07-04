# Basic usage of the linode_lke_cluster module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "lke_cluster" {
  source = "../.."

  label       = "test-lke-cluster"
  region      = "us-east"
  k8s_version = "1.32"

  pool = [
    {
      type  = "g6-standard-2"
      count = 3
    }
  ]
}
