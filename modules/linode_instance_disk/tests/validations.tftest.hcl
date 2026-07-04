# Plan-only tests for the linode_instance_disk module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run:
# terraform -chdir=modules/linode_instance_disk test

mock_provider "linode" {}

variables {
  linode_id = 123
  label     = "boot"
  size      = 1024
  # image is required for a valid plan: the provider ties authorized_users and
  # stackscript_data (always passed by the module) to image via RequiredWith.
  image = "linode/ubuntu22.04"
}

run "valid_disk_plans" {
  command = plan

  assert {
    condition     = linode_instance_disk.this.size == 1024
    error_message = "planned disk size should match the input"
  }
}

run "rejects_nonpositive_linode_id" {
  command = plan

  variables {
    linode_id = 0 # must be a positive integer
  }

  expect_failures = [var.linode_id]
}

run "rejects_bad_label" {
  command = plan

  variables {
    label = "bad name!" # spaces and "!" are not allowed
  }

  expect_failures = [var.label]
}

run "rejects_size_zero" {
  command = plan

  variables {
    size = 0 # disk size must be positive
  }

  expect_failures = [var.size]
}

run "rejects_bad_filesystem" {
  command = plan

  variables {
    filesystem = "zfs" # not one of raw, swap, ext3, ext4, initrd
  }

  expect_failures = [var.filesystem]
}

run "rejects_negative_stackscript_id" {
  command = plan

  variables {
    stackscript_id = -1 # must be positive when set
  }

  expect_failures = [var.stackscript_id]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
