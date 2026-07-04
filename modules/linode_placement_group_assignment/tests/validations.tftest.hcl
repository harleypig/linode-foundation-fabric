# Plan-only tests for the linode_placement_group_assignment module. command =
# plan never creates real infrastructure; mock_provider satisfies provider
# config so no Linode token is needed. Run:
# terraform -chdir=modules/linode_placement_group_assignment test

mock_provider "linode" {}

variables {
  placement_group_id = 12345
  linode_id          = 67890
}

run "valid_placement_group_assignment_plans" {
  command = plan

  assert {
    condition     = linode_placement_group_assignment.this.linode_id == 67890
    error_message = "planned linode_id should match the input"
  }
}

run "rejects_non_positive_placement_group_id" {
  command = plan

  variables {
    placement_group_id = 0 # must be a positive integer
  }

  expect_failures = [var.placement_group_id]
}

run "rejects_non_positive_linode_id" {
  command = plan

  variables {
    linode_id = -1 # must be a positive integer
  }

  expect_failures = [var.linode_id]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
