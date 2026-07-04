# Plan-only tests for the linode_user module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_user test

mock_provider "linode" {}

variables {
  username = "test-user"
  email    = "test-user@example.com"
}

run "valid_user_plans" {
  command = plan

  assert {
    condition     = linode_user.this.username == "test-user"
    error_message = "planned username should match the input"
  }

  assert {
    condition     = linode_user.this.restricted == false
    error_message = "restricted should default to false"
  }
}

run "rejects_short_username" {
  command = plan

  variables {
    username = "ab" # fewer than 3 characters
  }

  expect_failures = [var.username]
}

run "rejects_username_bad_start" {
  command = plan

  variables {
    username = "-bad" # must start with an alphanumeric character
  }

  expect_failures = [var.username]
}

run "rejects_invalid_email" {
  command = plan

  variables {
    email = "not-an-email" # missing @ and domain
  }

  expect_failures = [var.email]
}

run "rejects_invalid_account_access" {
  command = plan

  variables {
    global_grants = {
      account_access = "superuser" # only read_only or read_write
    }
  }

  expect_failures = [var.global_grants]
}

run "rejects_invalid_domain_grant" {
  command = plan

  variables {
    domain_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.domain_grant]
}

run "rejects_invalid_firewall_grant" {
  command = plan

  variables {
    firewall_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.firewall_grant]
}

run "rejects_invalid_image_grant" {
  command = plan

  variables {
    image_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.image_grant]
}

run "rejects_invalid_linode_grant" {
  command = plan

  variables {
    linode_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.linode_grant]
}

run "rejects_invalid_longview_grant" {
  command = plan

  variables {
    longview_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.longview_grant]
}

run "rejects_invalid_nodebalancer_grant" {
  command = plan

  variables {
    nodebalancer_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.nodebalancer_grant]
}

run "rejects_invalid_stackscript_grant" {
  command = plan

  variables {
    stackscript_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.stackscript_grant]
}

run "rejects_invalid_volume_grant" {
  command = plan

  variables {
    volume_grant = [{ id = 1, permissions = "admin" }] # only read_only or read_write
  }

  expect_failures = [var.volume_grant]
}

run "rejects_negative_grant_id" {
  command = plan

  variables {
    vpc_grant = [{ id = -1, permissions = "read_only" }] # entity id must be positive
  }

  expect_failures = [var.vpc_grant]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
