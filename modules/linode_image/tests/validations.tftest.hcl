# Plan-only tests for the linode_image module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_image test

mock_provider "linode" {}

variables {
  label     = "example-image"
  linode_id = 12345
  disk_id   = 67890
  tags      = ["example"]
}

run "valid_image_plans" {
  command = plan

  assert {
    condition     = linode_image.this.label == "example-image"
    error_message = "planned image label should match the input"
  }
}

run "rejects_long_label" {
  command = plan

  variables {
    label = "this-label-is-far-too-long-for-an-image-and-exceeds-fifty" # more than 50 characters
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

run "rejects_negative_disk_id" {
  command = plan

  variables {
    disk_id = -1 # must be positive when set
  }

  expect_failures = [var.disk_id]
}

run "rejects_negative_linode_id" {
  command = plan

  variables {
    linode_id = -1 # must be positive when set
  }

  expect_failures = [var.linode_id]
}

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_invalid_replica_region" {
  command = plan

  variables {
    replica_regions = ["us-east", "mars-1"] # mars-1 is not a valid Linode region
  }

  expect_failures = [var.replica_regions]
}

run "rejects_bad_file_hash" {
  command = plan

  variables {
    file_hash = "not-a-hash" # must be a 32-char hex MD5 digest
  }

  expect_failures = [var.file_hash]
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

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
