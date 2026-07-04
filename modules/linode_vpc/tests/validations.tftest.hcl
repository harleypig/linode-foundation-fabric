# Plan-only tests for the linode_vpc module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_vpc test

mock_provider "linode" {}

variables {
  label  = "test-vpc"
  region = "us-east"
}

run "valid_vpc_plans" {
  command = plan

  assert {
    condition     = linode_vpc.this.label == "test-vpc"
    error_message = "planned VPC label should match the input"
  }
}

run "rejects_label_bad_char" {
  command = plan

  variables {
    label = "bad_label" # underscore is not an allowed character
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

run "rejects_label_too_long" {
  command = plan

  variables {
    label = "a012345678901234567890123456789012345678901234567890123456789012345" # 66 chars, over the 64 max
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

run "rejects_long_description" {
  command = plan

  variables {
    description = "This description is deliberately padded well beyond the 255 character maximum so that the validation rejects it. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis."
  }

  expect_failures = [var.description]
}

run "rejects_multiple_ipv6" {
  command = plan

  variables {
    ipv6 = [{ range = "auto" }, { range = "auto" }] # at most one block allowed
  }

  expect_failures = [var.ipv6]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
