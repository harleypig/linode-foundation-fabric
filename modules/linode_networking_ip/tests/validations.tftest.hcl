# Plan-only tests for the linode_networking_ip module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run:
# terraform -chdir=modules/linode_networking_ip test

mock_provider "linode" {}

variables {
  linode_id = 12345
  public    = true
  type      = "ipv4"
}

run "valid_networking_ip_plans" {
  command = plan

  assert {
    condition     = linode_networking_ip.this.linode_id == 12345
    error_message = "planned linode_id should match the input"
  }
}

run "rejects_negative_linode_id" {
  command = plan

  variables {
    linode_id = -1 # must be positive when set
  }

  expect_failures = [var.linode_id]
}

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_invalid_type" {
  command = plan

  variables {
    type = "ipv6" # only ipv4 is supported by this resource
  }

  expect_failures = [var.type]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
