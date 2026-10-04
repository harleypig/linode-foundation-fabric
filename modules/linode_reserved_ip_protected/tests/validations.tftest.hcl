# Plan-only tests for the linode_reserved_ip_protected module (the
# prevent_destroy variant). The input validations mirror
# ../linode_reserved_ip. prevent_destroy acts only on a destroy or replace,
# which a plan-only create test does not reach, so the assertable behaviour
# here is identical; the guard itself is checked by the destroy-plan
# procedure in the README. command = plan never creates real infrastructure;
# mock_provider satisfies provider config so no Linode token is needed. Run:
# terraform -chdir=modules/linode_reserved_ip_protected test

mock_provider "linode" {}

variables {
  region = "us-east"
  tags   = ["prod", "web"]
}

run "valid_protected_reserved_ip_plans" {
  command = plan

  assert {
    condition     = linode_reserved_ip.this.region == "us-east"
    error_message = "planned region should match the input"
  }

  assert {
    condition     = length(linode_reserved_ip.this.tags) == 2
    error_message = "expected exactly two planned tags"
  }
}

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_too_many_tags" {
  command = plan

  variables {
    tags = [for i in range(65) : "tag-${i}"] # exceeds the 64-tag maximum
  }

  expect_failures = [var.tags]
}

run "rejects_invalid_tag_format" {
  command = plan

  variables {
    tags = ["ok-tag", "in valid!"] # spaces and "!" are not permitted
  }

  expect_failures = [var.tags]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
