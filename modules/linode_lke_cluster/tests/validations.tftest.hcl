# Plan-only tests for the linode_lke_cluster module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run:
# terraform -chdir=modules/linode_lke_cluster test

mock_provider "linode" {}

variables {
  label       = "test-lke-cluster"
  region      = "us-east"
  k8s_version = "1.32"
  pool = [
    {
      type  = "g6-standard-2"
      count = 3
    }
  ]
}

run "valid_lke_cluster_plans" {
  command = plan

  assert {
    condition     = linode_lke_cluster.this.k8s_version == "1.32"
    error_message = "planned cluster k8s_version should match the input"
  }

  assert {
    condition     = linode_lke_cluster.this.region == "us-east"
    error_message = "planned cluster region should match the input"
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

run "rejects_bad_k8s_version" {
  command = plan

  variables {
    k8s_version = "latest" # must be <major>.<minor>
  }

  expect_failures = [var.k8s_version]
}

run "rejects_invalid_tier" {
  command = plan

  variables {
    tier = "premium" # must be standard or enterprise
  }

  expect_failures = [var.tier]
}

run "rejects_negative_subnet_id" {
  command = plan

  variables {
    subnet_id = -1 # must be positive when set
  }

  expect_failures = [var.subnet_id]
}

run "rejects_negative_vpc_id" {
  command = plan

  variables {
    vpc_id = -1 # must be positive when set
  }

  expect_failures = [var.vpc_id]
}

run "rejects_too_many_tags" {
  command = plan

  variables {
    tags = [for i in range(65) : "tag-${i}"] # exceeds the 64-tag maximum
  }

  expect_failures = [var.tags]
}

run "rejects_bad_tag" {
  command = plan

  variables {
    tags = ["ok", "a"] # "a" is shorter than the 3-char minimum
  }

  expect_failures = [var.tags]
}

run "rejects_empty_pool_type" {
  command = plan

  variables {
    pool = [{ type = "" }] # each pool must specify a type
  }

  expect_failures = [var.pool]
}

run "rejects_negative_pool_count" {
  command = plan

  variables {
    pool = [{ type = "g6-standard-1", count = -1 }] # count must be >= 0
  }

  expect_failures = [var.pool]
}

run "rejects_bad_autoscaler" {
  command = plan

  variables {
    pool = [{
      type       = "g6-standard-1"
      autoscaler = { min = 5, max = 2 } # max must be >= min
    }]
  }

  expect_failures = [var.pool]
}

run "rejects_bad_disk_encryption" {
  command = plan

  variables {
    pool = [{
      type            = "g6-standard-1"
      disk_encryption = "maybe" # must be enabled or disabled
    }]
  }

  expect_failures = [var.pool]
}

run "rejects_bad_taint_effect" {
  command = plan

  variables {
    pool = [{
      type  = "g6-standard-1"
      taint = [{ effect = "Nope", key = "k", value = "v" }] # invalid effect
    }]
  }

  expect_failures = [var.pool]
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
