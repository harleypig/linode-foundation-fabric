# Plan-only tests for the linode_firewall_device module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_firewall_device test

mock_provider "linode" {}

variables {
  firewall_id = 123456
  entity_id   = 654321
}

run "valid_firewall_device_plans" {
  command = plan

  assert {
    condition     = linode_firewall_device.this.entity_id == 654321
    error_message = "planned firewall device entity_id should match the input"
  }
}

run "rejects_non_positive_firewall_id" {
  command = plan

  variables {
    firewall_id = 0 # must be a positive integer
  }

  expect_failures = [var.firewall_id]
}

run "rejects_non_positive_entity_id" {
  command = plan

  variables {
    entity_id = -1 # must be a positive integer
  }

  expect_failures = [var.entity_id]
}

run "rejects_invalid_entity_type" {
  command = plan

  variables {
    entity_type = "bogus" # not linode or nodebalancer
  }

  expect_failures = [var.entity_type]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
