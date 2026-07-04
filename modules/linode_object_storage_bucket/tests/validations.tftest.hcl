# Plan-only tests for the linode_object_storage_bucket module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config so
# no Linode token is needed. Run:
# terraform -chdir=tfmods/linode_object_storage_bucket test

mock_provider "linode" {}

variables {
  region = "us-east-1"
  label  = "harleypig-terraform-state"
}

run "valid_bucket_plans" {
  command = plan

  assert {
    condition     = linode_object_storage_bucket.this.label == "harleypig-terraform-state"
    error_message = "planned bucket label should match the input"
  }
}

run "rejects_bad_region" {
  command = plan

  variables {
    region = "useast1" # missing the hyphen, not a region/cluster id
  }

  expect_failures = [var.region]
}

run "rejects_short_label" {
  command = plan

  variables {
    label = "ab" # fewer than 3 characters
  }

  expect_failures = [var.label]
}

run "rejects_uppercase_label" {
  command = plan

  variables {
    label = "Bad-Bucket" # uppercase not allowed in an S3 bucket name
  }

  expect_failures = [var.label]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
