# Plan-only tests for the linode_reserved_ip_assignment module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config so
# no Linode token is needed. Run:
# terraform -chdir=modules/linode_reserved_ip_assignment test

mock_provider "linode" {}

variables {
  address   = "192.0.2.10"
  linode_id = 123456
}

run "valid_reserved_ip_assignment_plans" {
  command = plan

  assert {
    condition     = linode_reserved_ip_assignment.this.address == "192.0.2.10"
    error_message = "planned address should match the input"
  }
}

run "rejects_invalid_address" {
  command = plan

  variables {
    address = "not-an-ip" # must be a dotted-quad IPv4 address
  }

  expect_failures = [var.address]
}

run "rejects_non_positive_linode_id" {
  command = plan

  variables {
    linode_id = 0 # must be a positive integer
  }

  expect_failures = [var.linode_id]
}

run "rejects_bad_rdns" {
  command = plan

  variables {
    rdns = "-bad-.example." # not a valid hostname
  }

  expect_failures = [var.rdns]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
