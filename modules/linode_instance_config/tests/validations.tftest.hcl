# Plan-only tests for the linode_instance_config module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run:
# terraform -chdir=modules/linode_instance_config test

mock_provider "linode" {}

variables {
  linode_id = 123
  label     = "cfg"
}

run "valid_config_plans" {
  command = plan

  assert {
    condition     = linode_instance_config.this.label == "cfg"
    error_message = "planned config label should match the input"
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

run "rejects_negative_memory_limit" {
  command = plan

  variables {
    memory_limit = -1 # must be >= 0
  }

  expect_failures = [var.memory_limit]
}

run "rejects_bad_run_level" {
  command = plan

  variables {
    run_level = "weird" # not one of default, single, binbash
  }

  expect_failures = [var.run_level]
}

run "rejects_bad_virt_mode" {
  command = plan

  variables {
    virt_mode = "x" # must be paravirt or fullvirt
  }

  expect_failures = [var.virt_mode]
}

run "rejects_bad_device_name" {
  command = plan

  variables {
    devices = [{ device_name = "xyz" }] # must be one of sda..sdh
  }

  expect_failures = [var.devices]
}

run "rejects_bad_interface_purpose" {
  command = plan

  variables {
    interface = [{ purpose = "bad" }] # must be public, vlan, or vpc
  }

  expect_failures = [var.interface]
}

run "rejects_device_with_disk_and_volume" {
  command = plan

  variables {
    devices = [{ device_name = "sda", disk_id = 1, volume_id = 2 }] # not both
  }

  expect_failures = [var.devices]
}

run "rejects_vpc_interface_without_subnet" {
  command = plan

  variables {
    interface = [{ purpose = "vpc" }] # vpc requires subnet_id
  }

  expect_failures = [var.interface]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
