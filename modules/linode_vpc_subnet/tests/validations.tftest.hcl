# Plan-only tests for the linode_vpc_subnet module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_vpc_subnet test

mock_provider "linode" {}

variables {
  vpc_id = 12345
  label  = "test-subnet"
  ipv4   = "10.0.1.0/24"
}

run "valid_vpc_subnet_plans" {
  command = plan

  assert {
    condition     = linode_vpc_subnet.this.label == "test-subnet"
    error_message = "planned subnet label should match the input"
  }
}

run "rejects_label_bad_start" {
  command = plan

  variables {
    label = "-bad" # must start with an alphanumeric character
  }

  expect_failures = [var.label]
}

run "rejects_label_too_long" {
  command = plan

  variables {
    label = "this-label-is-way-too-long-to-be-accepted-by-the-linode-vpc-subnet-api" # over 64 chars
  }

  expect_failures = [var.label]
}

run "rejects_nonpositive_vpc_id" {
  command = plan

  variables {
    vpc_id = 0 # must be positive
  }

  expect_failures = [var.vpc_id]
}

run "rejects_invalid_ipv4" {
  command = plan

  variables {
    ipv4 = "not-a-cidr" # must be a valid IPv4 CIDR range
  }

  expect_failures = [var.ipv4]
}

run "rejects_invalid_ipv6_range" {
  command = plan

  variables {
    ipv6 = [{ range = "nonsense" }] # must be a prefix or /length
  }

  expect_failures = [var.ipv6]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
