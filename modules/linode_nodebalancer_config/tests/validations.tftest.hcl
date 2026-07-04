# Plan-only tests for the linode_nodebalancer_config module. command = plan
# never creates real infrastructure; mock_provider satisfies provider config
# so no Linode token is needed. Run:
# terraform -chdir=modules/linode_nodebalancer_config test

mock_provider "linode" {}

variables {
  nodebalancer_id = 12345
  port            = 80
  protocol        = "http"
  algorithm       = "roundrobin"
}

run "valid_nodebalancer_config_plans" {
  command = plan

  assert {
    condition     = linode_nodebalancer_config.this.port == 80
    error_message = "planned config port should match the input"
  }

  assert {
    condition     = linode_nodebalancer_config.this.protocol == "http"
    error_message = "planned config protocol should match the input"
  }
}

run "rejects_zero_nodebalancer_id" {
  command = plan

  variables {
    nodebalancer_id = 0 # must be a positive integer
  }

  expect_failures = [var.nodebalancer_id]
}

run "rejects_invalid_port" {
  command = plan

  variables {
    port = 70000 # above the 65535 maximum
  }

  expect_failures = [var.port]
}

run "rejects_invalid_protocol" {
  command = plan

  variables {
    protocol = "ftp" # only tcp, http, https
  }

  expect_failures = [var.protocol]
}

run "rejects_invalid_proxy_protocol" {
  command = plan

  variables {
    proxy_protocol = "v3" # only none, v1, v2
  }

  expect_failures = [var.proxy_protocol]
}

run "rejects_invalid_algorithm" {
  command = plan

  variables {
    algorithm = "random" # only roundrobin, leastconn, source
  }

  expect_failures = [var.algorithm]
}

run "rejects_invalid_stickiness" {
  command = plan

  variables {
    stickiness = "always" # only none, table, http_cookie
  }

  expect_failures = [var.stickiness]
}

run "rejects_invalid_check" {
  command = plan

  variables {
    check = "ping" # only none, connection, http, http_body
  }

  expect_failures = [var.check]
}

run "rejects_invalid_check_timeout" {
  command = plan

  variables {
    check_timeout = 45 # above the 30 second maximum
  }

  expect_failures = [var.check_timeout]
}

run "rejects_invalid_check_attempts" {
  command = plan

  variables {
    check_attempts = 0 # below the minimum of 1
  }

  expect_failures = [var.check_attempts]
}

run "rejects_negative_check_interval" {
  command = plan

  variables {
    check_interval = -5 # must be non-negative
  }

  expect_failures = [var.check_interval]
}

run "rejects_invalid_cipher_suite" {
  command = plan

  variables {
    cipher_suite = "modern" # only recommended, legacy
  }

  expect_failures = [var.cipher_suite]
}

run "rejects_invalid_udp_check_port" {
  command = plan

  variables {
    udp_check_port = 0 # below the 1 minimum
  }

  expect_failures = [var.udp_check_port]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
