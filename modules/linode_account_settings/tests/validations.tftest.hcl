# Plan-only tests for the linode_account_settings module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_account_settings test

mock_provider "linode" {}

variables {
  backups_enabled            = true
  network_helper             = true
  interfaces_for_new_linodes = "linode_only"
  maintenance_policy         = "linode/migrate"
}

run "valid_account_settings_plans" {
  command = plan

  assert {
    condition     = linode_account_settings.this.maintenance_policy == "linode/migrate"
    error_message = "planned maintenance policy should match the input"
  }
}

run "rejects_invalid_interfaces_for_new_linodes" {
  command = plan

  variables {
    interfaces_for_new_linodes = "eth0" # not a valid interfaces mode
  }

  expect_failures = [var.interfaces_for_new_linodes]
}

run "rejects_invalid_maintenance_policy" {
  command = plan

  variables {
    maintenance_policy = "linode/reboot" # not a valid maintenance policy
  }

  expect_failures = [var.maintenance_policy]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
