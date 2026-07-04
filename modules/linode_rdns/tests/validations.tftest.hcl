# Plan-only tests for the linode_rdns module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_rdns test

mock_provider "linode" {}

variables {
  rdns = {
    web = {
      address = "192.0.2.10"
      rdns    = "web.example.com"
    }
  }
}

run "valid_rdns_plans" {
  command = plan

  assert {
    condition     = length(linode_rdns.rdns) == 1
    error_message = "expected exactly one planned rdns resource"
  }
}

run "rejects_bad_address" {
  command = plan

  variables {
    rdns = {
      bad = {
        address = "not-an-ip" # neither a valid IPv4 nor IPv6 address
        rdns    = "x.example.com"
      }
    }
  }

  expect_failures = [var.rdns]
}

run "rejects_empty_hostname" {
  command = plan

  variables {
    rdns = {
      bad = {
        address = "192.0.2.10"
        rdns    = "" # hostname must be non-empty
      }
    }
  }

  expect_failures = [var.rdns]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
