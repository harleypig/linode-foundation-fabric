# Basic usage of the linode_object_storage_key module. This example doubles as
# a plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "object_storage_key" {
  source = "../.."

  label = "test-storage-key"

  bucket_access = [{
    bucket_name = "my-app-assets"
    permissions = "read_only"
    region      = "us-east"
  }]
}
