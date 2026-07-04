# Plan-only tests for the linode_interface module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_interface test

mock_provider "linode" {}

variables {
  linode_id = 12345
  public    = {}
}

run "valid_interface_plans" {
  command = plan

  assert {
    condition     = linode_interface.this.linode_id == 12345
    error_message = "planned interface linode_id should match the input"
  }
}

run "rejects_negative_linode_id" {
  command = plan

  variables {
    linode_id = -1 # must be positive
  }

  expect_failures = [var.linode_id]
}

run "rejects_negative_firewall_id" {
  command = plan

  variables {
    firewall_id = -5 # must be positive when set
  }

  expect_failures = [var.firewall_id]
}

run "rejects_vlan_label_bad_start" {
  command = plan

  variables {
    public = null
    vlan = {
      vlan_label = "-bad" # must start with an alphanumeric character
    }
  }

  expect_failures = [var.vlan]
}

run "rejects_vlan_label_too_long" {
  command = plan

  variables {
    public = null
    vlan = {
      # 65 characters, exceeding the 64-character maximum
      vlan_label = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    }
  }

  expect_failures = [var.vlan]
}

run "rejects_nonpositive_vpc_subnet_id" {
  command = plan

  variables {
    public = null
    vpc = {
      subnet_id = 0 # must be a positive integer
    }
  }

  expect_failures = [var.vpc]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
