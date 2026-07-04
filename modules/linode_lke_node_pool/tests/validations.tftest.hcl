# Plan-only tests for the linode_lke_node_pool module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_lke_node_pool test

mock_provider "linode" {}

variables {
  cluster_id = 12345
  type       = "g6-standard-1"
  node_count = 3
}

run "valid_lke_node_pool_plans" {
  command = plan

  assert {
    condition     = linode_lke_node_pool.this.type == "g6-standard-1"
    error_message = "planned node pool type should match the input"
  }

  assert {
    condition     = linode_lke_node_pool.this.node_count == 3
    error_message = "planned node count should match the input"
  }
}

run "rejects_invalid_cluster_id" {
  command = plan

  variables {
    cluster_id = 0 # must be a positive integer
  }

  expect_failures = [var.cluster_id]
}

run "rejects_invalid_type" {
  command = plan

  variables {
    type = "not-a-type" # must look like g6-standard-1
  }

  expect_failures = [var.type]
}

run "rejects_invalid_node_count" {
  command = plan

  variables {
    node_count = 0 # must be at least 1 when set
  }

  expect_failures = [var.node_count]
}

run "rejects_invalid_label" {
  command = plan

  variables {
    label = "-bad" # must start with an alphanumeric character
  }

  expect_failures = [var.label]
}

run "rejects_invalid_disk_encryption" {
  command = plan

  variables {
    disk_encryption = "maybe" # must be enabled or disabled
  }

  expect_failures = [var.disk_encryption]
}

run "rejects_invalid_update_strategy" {
  command = plan

  variables {
    update_strategy = "big_bang" # must be rolling_update or on_recreate
  }

  expect_failures = [var.update_strategy]
}

run "rejects_invalid_firewall_id" {
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

run "rejects_bad_autoscaler" {
  command = plan

  variables {
    autoscaler = { min = 5, max = 2 } # max must be >= min
  }

  expect_failures = [var.autoscaler]
}

run "rejects_bad_taint_effect" {
  command = plan

  variables {
    taints = [{ effect = "Nope", key = "dedicated", value = "gpu" }]
  }

  expect_failures = [var.taints]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
