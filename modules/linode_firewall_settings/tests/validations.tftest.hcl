# Plan-only tests for the linode_firewall_settings module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_firewall_settings test

mock_provider "linode" {}

variables {
  default_firewall_ids = {
    linode = 12345
  }
}

run "valid_firewall_settings_plans" {
  command = plan

  assert {
    condition     = linode_firewall_settings.this.default_firewall_ids.linode == 12345
    error_message = "planned linode default firewall id should match the input"
  }
}

run "rejects_non_positive_firewall_id" {
  command = plan

  variables {
    default_firewall_ids = {
      linode = -1 # firewall IDs must be positive integers
    }
  }

  expect_failures = [var.default_firewall_ids]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
