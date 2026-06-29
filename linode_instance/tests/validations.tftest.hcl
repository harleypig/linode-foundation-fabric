# Plan-only tests for the linode_instance module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=tfmods/linode_instance test
#
# image is required for a valid plan: the provider ties swap_size, resize_disk,
# and stackscript_data to image via RequiredWith, so a plan without image
# errors.

mock_provider "linode" {}

variables {
  region = "us-central"
  type   = "g6-standard-1"
  image  = "linode/ubuntu22.04"
}

run "valid_instance_plans" {
  command = plan

  assert {
    condition     = linode_instance.instance.region == "us-central"
    error_message = "planned region should match the input"
  }
}

run "rejects_bad_region" {
  command = plan

  variables {
    region = "mars" # not a valid Linode region id
  }

  expect_failures = [var.region]
}

run "rejects_bad_type" {
  command = plan

  variables {
    type = "banana" # not a valid Linode type id
  }

  expect_failures = [var.type]
}

run "rejects_short_label" {
  command = plan

  variables {
    label = "ab" # fewer than 3 characters
  }

  expect_failures = [var.label]
}

run "rejects_bad_tag" {
  command = plan

  variables {
    tags = ["a"] # shorter than the 3-char minimum
  }

  expect_failures = [var.tags]
}

run "rejects_bad_migration_type" {
  command = plan

  variables {
    migration_type = "sideways" # must be warm or cold
  }

  expect_failures = [var.migration_type]
}

run "rejects_bad_disk_encryption" {
  command = plan

  variables {
    disk_encryption = "maybe" # must be enabled or disabled
  }

  expect_failures = [var.disk_encryption]
}

run "rejects_negative_swap" {
  command = plan

  variables {
    swap_size = -1 # must be >= 0
  }

  expect_failures = [var.swap_size]
}

run "rejects_bad_firewall_id" {
  command = plan

  variables {
    firewall_id = "abc" # must be a numeric ID string
  }

  expect_failures = [var.firewall_id]
}

run "rejects_bad_timeout" {
  command = plan

  variables {
    timeouts = { create = "5x" } # must be <number>[smh]
  }

  expect_failures = [var.timeouts]
}

run "rejects_negative_alert" {
  command = plan

  variables {
    alerts = { cpu = -1 } # thresholds must be >= 0
  }

  expect_failures = [var.alerts]
}
