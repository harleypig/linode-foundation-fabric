# Plan-only tests for the linode_ipv6_range module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_ipv6_range test

mock_provider "linode" {}

variables {
  prefix_length = 64
  linode_id     = 12345
}

run "valid_ipv6_range_plans" {
  command = plan

  assert {
    condition     = linode_ipv6_range.this.prefix_length == 64
    error_message = "planned prefix length should match the input"
  }
}

run "rejects_invalid_prefix_length" {
  command = plan

  variables {
    prefix_length = 48 # only 56 or 64 are allowed
  }

  expect_failures = [var.prefix_length]
}

run "rejects_negative_linode_id" {
  command = plan

  variables {
    linode_id = -1 # must be positive when set
  }

  expect_failures = [var.linode_id]
}

run "rejects_invalid_route_target" {
  command = plan

  variables {
    linode_id    = null
    route_target = "not-an-address" # must be a valid IPv6 address
  }

  expect_failures = [var.route_target]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
