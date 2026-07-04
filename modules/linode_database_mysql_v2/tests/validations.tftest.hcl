# Plan-only tests for the linode_database_mysql_v2 module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config
# so no Linode token is needed.
# Run: terraform -chdir=modules/linode_database_mysql_v2 test

mock_provider "linode" {}

variables {
  label     = "test-mysql-db"
  engine_id = "mysql/8"
  region    = "us-east"
  type      = "g6-nanode-1"
}

run "valid_database_mysql_v2_plans" {
  command = plan

  assert {
    condition     = linode_database_mysql_v2.this.label == "test-mysql-db"
    error_message = "planned database label should match the input"
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

run "rejects_invalid_engine_id" {
  command = plan

  variables {
    engine_id = "postgres/16" # must be a mysql engine id
  }

  expect_failures = [var.engine_id]
}

run "rejects_invalid_region" {
  command = plan

  variables {
    region = "mars-1" # not a valid Linode region
  }

  expect_failures = [var.region]
}

run "rejects_invalid_type" {
  command = plan

  variables {
    type = "bad-type" # not a valid Linode instance type
  }

  expect_failures = [var.type]
}

run "rejects_invalid_cluster_size" {
  command = plan

  variables {
    cluster_size = 4 # must be 1, 2, or 3
  }

  expect_failures = [var.cluster_size]
}

run "rejects_negative_fork_source" {
  command = plan

  variables {
    fork_source = -1 # must be positive when set
  }

  expect_failures = [var.fork_source]
}

run "rejects_invalid_flush_neighbors" {
  command = plan

  variables {
    engine_config_mysql_innodb_flush_neighbors = 5 # must be 0, 1, or 2
  }

  expect_failures = [var.engine_config_mysql_innodb_flush_neighbors]
}

run "rejects_invalid_change_buffer_max_size" {
  command = plan

  variables {
    engine_config_mysql_innodb_change_buffer_max_size = 150 # percentage must be 0-100
  }

  expect_failures = [var.engine_config_mysql_innodb_change_buffer_max_size]
}

run "rejects_bad_private_network" {
  command = plan

  variables {
    private_network = { subnet_id = -1, vpc_id = 1 } # ids must be positive
  }

  expect_failures = [var.private_network]
}

run "rejects_bad_update_day_of_week" {
  command = plan

  variables {
    updates = { day_of_week = 9 } # must be 1-7
  }

  expect_failures = [var.updates]
}

run "rejects_bad_timeout_format" {
  command = plan

  variables {
    timeouts = { create = "5x" } # must be <number>[smh]
  }

  expect_failures = [var.timeouts]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
