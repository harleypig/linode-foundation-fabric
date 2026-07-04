# Plan-only tests for the linode_instance_ip module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=tfmods/linode_instance_ip test

mock_provider "linode" {}

variables {
  linode_id = 123
}

run "valid_ip_plans" {
  command = plan

  assert {
    condition     = linode_instance_ip.this.linode_id == 123
    error_message = "planned linode_id should match the input"
  }
}

run "rejects_nonpositive_linode_id" {
  command = plan

  variables {
    linode_id = 0 # must be a positive integer
  }

  expect_failures = [var.linode_id]
}

run "rejects_bad_rdns" {
  command = plan

  variables {
    rdns = "bad host" # spaces are not valid in a hostname
  }

  expect_failures = [var.rdns]
}
