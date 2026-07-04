# Plan-only tests for the linode_token module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_token test

mock_provider "linode" {}

variables {
  label  = "test-token"
  scopes = "linodes:read_write domains:read_only"
  expiry = "2030-01-01T00:00:00Z"
}

run "valid_token_plans" {
  command = plan

  assert {
    condition     = linode_token.this.scopes == "linodes:read_write domains:read_only"
    error_message = "planned token scopes should match the input"
  }
}

run "rejects_invalid_scopes" {
  command = plan

  variables {
    scopes = "invalid scopes format!!" # not <resource>:<access> tokens
  }

  expect_failures = [var.scopes]
}

run "rejects_long_label" {
  command = plan

  variables {
    label = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" # 101 chars, over the max
  }

  expect_failures = [var.label]
}

run "rejects_bad_label_chars" {
  command = plan

  variables {
    label = "bad label!" # spaces and punctuation are not allowed
  }

  expect_failures = [var.label]
}

run "rejects_bad_expiry" {
  command = plan

  variables {
    expiry = "2030-13-01" # not the RFC 3339 timestamp format
  }

  expect_failures = [var.expiry]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
