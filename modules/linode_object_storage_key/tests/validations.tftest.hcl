# Plan-only tests for the linode_object_storage_key module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config so
# no Linode token is needed. Run: terraform -chdir=modules/linode_object_storage_key test

mock_provider "linode" {}

variables {
  label = "test-storage-key"
  bucket_access = [{
    bucket_name = "my-app-assets"
    permissions = "read_only"
    region      = "us-east"
  }]
}

run "valid_object_storage_key_plans" {
  command = plan

  assert {
    condition     = linode_object_storage_key.this.label == "test-storage-key"
    error_message = "planned key label should match the input"
  }

  assert {
    condition     = length(linode_object_storage_key.this.bucket_access) == 1
    error_message = "expected exactly one planned bucket_access entry"
  }
}

run "rejects_short_label" {
  command = plan

  variables {
    label = "ab" # fewer than 3 characters
  }

  expect_failures = [var.label]
}

run "rejects_label_bad_start" {
  command = plan

  variables {
    label = "-bad" # must start with an alphanumeric character
  }

  expect_failures = [var.label]
}

run "rejects_invalid_region" {
  command = plan

  variables {
    regions = ["US-EAST"] # must be a lowercase region code
  }

  expect_failures = [var.regions]
}

run "rejects_invalid_bucket_permissions" {
  command = plan

  variables {
    bucket_access = [{
      bucket_name = "my-app-assets"
      permissions = "read" # only read_only or read_write
      region      = "us-east"
    }]
  }

  expect_failures = [var.bucket_access]
}

run "rejects_invalid_bucket_region" {
  command = plan

  variables {
    bucket_access = [{
      bucket_name = "my-app-assets"
      permissions = "read_only"
      region      = "US-EAST" # must be a lowercase region code
    }]
  }

  expect_failures = [var.bucket_access]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
