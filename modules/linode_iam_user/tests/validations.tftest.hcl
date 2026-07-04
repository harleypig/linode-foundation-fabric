# Plan-only tests for the linode_iam_user module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_iam_user test

mock_provider "linode" {}

variables {
  username = "test-iam-user"
}

run "valid_iam_user_plans" {
  command = plan

  assert {
    condition     = linode_iam_user.this.username == "test-iam-user"
    error_message = "planned username should match the input"
  }
}

run "rejects_short_username" {
  command = plan

  variables {
    username = "ab" # fewer than 3 characters
  }

  expect_failures = [var.username]
}

run "rejects_username_bad_start" {
  command = plan

  variables {
    username = "-bad" # must start with an alphanumeric character
  }

  expect_failures = [var.username]
}

run "rejects_empty_account_access" {
  command = plan

  variables {
    account_access = [""] # each entry must be non-empty
  }

  expect_failures = [var.account_access]
}

run "rejects_nonpositive_entity_id" {
  command = plan

  variables {
    entity_access = [{
      id    = 0 # must be a positive integer
      roles = ["linode_viewer"]
      type  = "linode"
    }]
  }

  expect_failures = [var.entity_access]
}

run "rejects_empty_entity_roles" {
  command = plan

  variables {
    entity_access = [{
      id    = 123456
      roles = [] # must specify at least one role
      type  = "linode"
    }]
  }

  expect_failures = [var.entity_access]
}

run "rejects_empty_entity_type" {
  command = plan

  variables {
    entity_access = [{
      id    = 123456
      roles = ["linode_viewer"]
      type  = "" # must be non-empty
    }]
  }

  expect_failures = [var.entity_access]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
