# Plan-only tests for the linode_placement_group module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_placement_group test

mock_provider "linode" {}

variables {
  label                  = "test-placement-group"
  region                 = "us-east"
  placement_group_type   = "anti_affinity:local"
  placement_group_policy = "strict"
}

run "valid_placement_group_plans" {
  command = plan

  assert {
    condition     = linode_placement_group.this.placement_group_type == "anti_affinity:local"
    error_message = "planned placement group type should match the input"
  }
}

run "rejects_short_label" {
  command = plan

  variables {
    label = "" # fewer than 1 character
  }

  expect_failures = [var.label]
}

run "rejects_label_bad_start" {
  command = plan

  variables {
    label = "-bad" # must start with an alphanumeric character
  }

  expect_failures = [var.label]
}

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_invalid_placement_group_type" {
  command = plan

  variables {
    placement_group_type = "affinity:global" # unsupported type
  }

  expect_failures = [var.placement_group_type]
}

run "rejects_invalid_placement_group_policy" {
  command = plan

  variables {
    placement_group_policy = "loose" # must be strict or flexible
  }

  expect_failures = [var.placement_group_policy]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
