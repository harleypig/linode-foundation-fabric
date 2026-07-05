# Plan-only tests for the linode_lock module. command = plan never creates real
# infrastructure; mock_provider satisfies provider config so no Linode token is
# needed. Run:
# terraform -chdir=modules/linode_lock test

mock_provider "linode" {}

variables {
  entity_id   = 123456
  entity_type = "volume"
  lock_type   = "cannot_delete"
}

run "valid_lock_plans" {
  command = plan

  assert {
    condition     = linode_lock.this.entity_id == 123456
    error_message = "planned entity_id should match the input"
  }

  assert {
    condition     = linode_lock.this.lock_type == "cannot_delete"
    error_message = "planned lock_type should match the input"
  }
}

run "rejects_non_positive_entity_id" {
  command = plan

  variables {
    entity_id = 0 # must be a positive integer
  }

  expect_failures = [var.entity_id]
}

run "rejects_invalid_entity_type" {
  command = plan

  variables {
    entity_type = "bucket" # not a lockable entity type
  }

  expect_failures = [var.entity_type]
}

run "rejects_invalid_lock_type" {
  command = plan

  variables {
    lock_type = "read_only" # only cannot_delete[_with_subresources] are valid
  }

  expect_failures = [var.lock_type]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
