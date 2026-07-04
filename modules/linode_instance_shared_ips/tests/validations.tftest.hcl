# Plan-only tests for the linode_instance_shared_ips module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config
# so no Linode token is needed. Run:
# terraform -chdir=modules/linode_instance_shared_ips test

mock_provider "linode" {}

variables {
  linode_id = 12345
  addresses = ["192.0.2.10", "2600:3c00::f03c:0:0:1"]
}

run "valid_instance_shared_ips_plans" {
  command = plan

  assert {
    condition     = linode_instance_shared_ips.this.linode_id == 12345
    error_message = "planned linode_id should match the input"
  }
}

run "rejects_non_positive_linode_id" {
  command = plan

  variables {
    linode_id = -1 # must be a positive integer
  }

  expect_failures = [var.linode_id]
}

run "rejects_empty_addresses" {
  command = plan

  variables {
    addresses = [] # at least one address is required
  }

  expect_failures = [var.addresses]
}

run "rejects_invalid_address" {
  command = plan

  variables {
    addresses = ["nope"] # not a valid IPv4 or IPv6 address
  }

  expect_failures = [var.addresses]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
