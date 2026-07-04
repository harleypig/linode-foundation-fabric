# Plan-only tests for the linode_nodebalancer_node module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config
# so no Linode token is needed. Run:
# terraform -chdir=modules/linode_nodebalancer_node test

mock_provider "linode" {}

variables {
  nodebalancer_id = 12345
  config_id       = 67890
  address         = "192.168.1.100:80"
  label           = "web-backend-1"
  mode            = "accept"
  weight          = 50
}

run "valid_nodebalancer_node_plans" {
  command = plan

  assert {
    condition     = linode_nodebalancer_node.this.address == "192.168.1.100:80"
    error_message = "planned node address should match the input"
  }
}

run "rejects_bad_address" {
  command = plan

  variables {
    address = "not-an-ip" # must be IP:PORT
  }

  expect_failures = [var.address]
}

run "rejects_non_positive_config_id" {
  command = plan

  variables {
    config_id = 0 # must be a positive integer
  }

  expect_failures = [var.config_id]
}

run "rejects_non_positive_nodebalancer_id" {
  command = plan

  variables {
    nodebalancer_id = -1 # must be a positive integer
  }

  expect_failures = [var.nodebalancer_id]
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

run "rejects_invalid_mode" {
  command = plan

  variables {
    mode = "pause" # not one of accept/reject/drain/backup
  }

  expect_failures = [var.mode]
}

run "rejects_weight_out_of_range" {
  command = plan

  variables {
    weight = 300 # above the 255 maximum
  }

  expect_failures = [var.weight]
}

run "rejects_non_positive_subnet_id" {
  command = plan

  variables {
    subnet_id = 0 # must be positive when set
  }

  expect_failures = [var.subnet_id]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
