# Plan-only tests for the linode_networking_ip_assignment module. command =
# plan never creates real infrastructure; mock_provider satisfies provider
# config so no Linode token is needed. Run:
# terraform -chdir=modules/linode_networking_ip_assignment test

mock_provider "linode" {}

variables {
  region = "us-east"
  assignments = [{
    address   = "192.0.2.10"
    linode_id = 12345
  }]
}

run "valid_networking_ip_assignment_plans" {
  command = plan

  assert {
    condition     = linode_networking_ip_assignment.this.region == "us-east"
    error_message = "planned region should match the input"
  }

  assert {
    condition     = length(linode_networking_ip_assignment.this.assignments) == 1
    error_message = "expected exactly one planned assignment"
  }
}

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_empty_address" {
  command = plan

  variables {
    assignments = [{
      address   = "" # must be a non-empty IP address
      linode_id = 12345
    }]
  }

  expect_failures = [var.assignments]
}

run "rejects_negative_linode_id" {
  command = plan

  variables {
    assignments = [{
      address   = "192.0.2.10"
      linode_id = -1 # must be positive
    }]
  }

  expect_failures = [var.assignments]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
