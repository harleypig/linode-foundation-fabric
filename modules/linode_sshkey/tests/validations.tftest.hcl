# Plan-only tests for the linode_sshkey module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_sshkey test

mock_provider "linode" {}

variables {
  label   = "harleypig-laptop"
  ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAItest harleypig@example"
}

run "valid_sshkey_plans" {
  command = plan

  assert {
    condition     = linode_sshkey.this.label == "harleypig-laptop"
    error_message = "planned label should match the input"
  }
}

run "rejects_empty_label" {
  command = plan

  variables {
    label = "" # fewer than 1 character
  }

  expect_failures = [var.label]
}

run "rejects_bad_ssh_key" {
  command = plan

  variables {
    ssh_key = "not-a-public-key" # missing a valid key-type prefix
  }

  expect_failures = [var.ssh_key]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
