# Plan-only tests for the linode_database_postgresql_v2 module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config so
# no Linode token is needed.
# Run: terraform -chdir=modules/linode_database_postgresql_v2 test

mock_provider "linode" {}

variables {
  engine_id = "postgresql/16"
  label     = "test-pg-db"
  region    = "us-east"
  type      = "g6-nanode-1"
}

run "valid_database_postgresql_v2_plans" {
  command = plan

  assert {
    condition     = linode_database_postgresql_v2.this.label == "test-pg-db"
    error_message = "planned database label should match the input"
  }
}

run "rejects_bad_engine_id" {
  command = plan

  variables {
    engine_id = "mysql/8" # not a postgresql engine id
  }

  expect_failures = [var.engine_id]
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

run "rejects_bad_type" {
  command = plan

  variables {
    type = "invalid" # must be a Linode instance type
  }

  expect_failures = [var.type]
}

run "rejects_bad_cluster_size" {
  command = plan

  variables {
    cluster_size = 5 # must be 1, 2, or 3
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

run "rejects_bad_allow_list" {
  command = plan

  variables {
    allow_list = ["notanip"] # not a valid IP/CIDR
  }

  expect_failures = [var.allow_list]
}

run "rejects_bad_private_network" {
  command = plan

  variables {
    private_network = { subnet_id = 0, vpc_id = 1 } # subnet_id must be positive
  }

  expect_failures = [var.private_network]
}

run "rejects_bad_update_day" {
  command = plan

  variables {
    updates = { day_of_week = 9 } # must be 1-7
  }

  expect_failures = [var.updates]
}

run "rejects_bad_update_hour" {
  command = plan

  variables {
    updates = { hour_of_day = 25 } # must be 0-23
  }

  expect_failures = [var.updates]
}

run "rejects_bad_update_frequency" {
  command = plan

  variables {
    updates = { frequency = "daily" } # can only be weekly
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

run "rejects_bad_shared_buffers" {
  command = plan

  variables {
    engine_config_shared_buffers_percentage = 10 # must be 20-60
  }

  expect_failures = [var.engine_config_shared_buffers_percentage]
}

run "rejects_bad_stat_statements_track" {
  command = plan

  variables {
    engine_config_pg_pg_stat_statements_track = "invalid" # must be top/all/none
  }

  expect_failures = [var.engine_config_pg_pg_stat_statements_track]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
