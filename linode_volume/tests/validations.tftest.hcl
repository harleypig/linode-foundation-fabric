# Plan-only tests for the linode_volume module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=tfmods/linode_volume test

mock_provider "linode" {}

variables {
  label  = "test-volume"
  size   = 20
  region = "us-east"
}

run "valid_volume_plans" {
  command = plan

  assert {
    condition     = linode_volume.this.size == 20
    error_message = "planned volume size should match the input"
  }
}

run "rejects_short_label" {
  command = plan

  variables {
    label = "ab" # fewer than 3 characters
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

run "rejects_size_too_small" {
  command = plan

  variables {
    size = 5 # below the 10 GB minimum
  }

  expect_failures = [var.size]
}

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_negative_linode_id" {
  command = plan

  variables {
    linode_id = -1 # must be positive when set
  }

  expect_failures = [var.linode_id]
}

run "rejects_bad_tag" {
  command = plan

  variables {
    tags = ["ok", "a"] # "a" is shorter than the 3-char minimum
  }

  expect_failures = [var.tags]
}

run "rejects_bad_timeout_format" {
  command = plan

  variables {
    timeouts = { create = "5x" } # must be <number>[smh]
  }

  expect_failures = [var.timeouts]
}
