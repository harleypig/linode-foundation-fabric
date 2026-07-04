# Plan-only tests for the linode_nodebalancer module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_nodebalancer test

mock_provider "linode" {}

variables {
  label  = "test-nodebalancer"
  region = "us-east"
}

run "valid_nodebalancer_plans" {
  command = plan

  assert {
    condition     = linode_nodebalancer.this.label == "test-nodebalancer"
    error_message = "planned NodeBalancer label should match the input"
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

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_conn_throttle_out_of_range" {
  command = plan

  variables {
    client_conn_throttle = 21 # above the 0-20 range
  }

  expect_failures = [var.client_conn_throttle]
}

run "rejects_udp_throttle_out_of_range" {
  command = plan

  variables {
    client_udp_sess_throttle = 25 # above the 0-20 range
  }

  expect_failures = [var.client_udp_sess_throttle]
}

run "rejects_negative_firewall_id" {
  command = plan

  variables {
    firewall_id = -1 # must be positive when set
  }

  expect_failures = [var.firewall_id]
}

run "rejects_bad_tag" {
  command = plan

  variables {
    tags = ["ok", "a"] # "a" is shorter than the 3-char minimum
  }

  expect_failures = [var.tags]
}

run "rejects_bad_subnet_id" {
  command = plan

  variables {
    vpcs = [{ subnet_id = 0 }] # subnet_id must be a positive integer
  }

  expect_failures = [var.vpcs]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
