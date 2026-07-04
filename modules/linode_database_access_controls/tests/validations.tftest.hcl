# Plan-only tests for the linode_database_access_controls module. command =
# plan never creates real infrastructure; mock_provider satisfies provider
# config so no Linode token is needed. Run:
# terraform -chdir=modules/linode_database_access_controls test

mock_provider "linode" {}

variables {
  database_id   = 12345
  database_type = "mysql"
  allow_list    = ["203.0.113.1", "192.168.1.0/24"]
}

run "valid_database_access_controls_plans" {
  command = plan

  assert {
    condition     = linode_database_access_controls.this.database_id == 12345
    error_message = "planned database_id should match the input"
  }
}

run "rejects_nonpositive_database_id" {
  command = plan

  variables {
    database_id = 0 # must be a positive integer
  }

  expect_failures = [var.database_id]
}

run "rejects_invalid_database_type" {
  command = plan

  variables {
    database_type = "mongodb" # not a supported engine
  }

  expect_failures = [var.database_type]
}

run "rejects_empty_allow_list" {
  command = plan

  variables {
    allow_list = [] # at least one entry is required
  }

  expect_failures = [var.allow_list]
}

run "rejects_invalid_allow_list_entry" {
  command = plan

  variables {
    allow_list = ["not-an-ip"] # not a valid IP or CIDR
  }

  expect_failures = [var.allow_list]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
