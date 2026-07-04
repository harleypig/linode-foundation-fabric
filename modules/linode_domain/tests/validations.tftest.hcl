# Plan-only tests for the linode_domain module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=modules/linode_domain test
#
# Note: the *_sec fields are `optional` and null-safe — an omitted field (null)
# is accepted; a non-null value must be one of the allowed Linode intervals.

mock_provider "linode" {}

variables {
  domains = {
    "example.com" = {
      domain      = "example.com"
      soa_email   = "admin@example.com"
      ttl_sec     = 300
      retry_sec   = 300
      expire_sec  = 300
      refresh_sec = 300
    }
  }
}

run "valid_domain_plans" {
  command = plan

  assert {
    condition     = length(linode_domain.domains) == 1
    error_message = "expected exactly one planned domain"
  }
}

run "rejects_invalid_ttl_sec" {
  command = plan

  variables {
    domains = {
      "example.com" = {
        domain      = "example.com"
        soa_email   = "admin@example.com"
        ttl_sec     = 999 # not in the allowed set
        retry_sec   = 300
        expire_sec  = 300
        refresh_sec = 300
      }
    }
  }

  expect_failures = [var.domains]
}

run "rejects_invalid_refresh_sec" {
  command = plan

  variables {
    domains = {
      "example.com" = {
        domain      = "example.com"
        soa_email   = "admin@example.com"
        ttl_sec     = 300
        retry_sec   = 300
        expire_sec  = 300
        refresh_sec = 12345 # not in the allowed set
      }
    }
  }

  expect_failures = [var.domains]
}

run "valid_with_omitted_sec" {
  command = plan

  variables {
    domains = {
      "example.com" = {
        domain    = "example.com"
        soa_email = "admin@example.com"
        # *_sec omitted -> null -> accepted (null-safe)
      }
    }
  }

  assert {
    condition     = length(linode_domain.domains) == 1
    error_message = "a domain with omitted *_sec fields should plan"
  }
}

run "rejects_bad_domain" {
  command = plan

  variables {
    domains = {
      bad = {
        domain    = "not a domain"
        soa_email = "admin@example.com"
      }
    }
  }

  expect_failures = [var.domains]
}

run "rejects_bad_soa_email" {
  command = plan

  variables {
    domains = {
      bad = {
        domain    = "example.com"
        soa_email = "not-an-email"
      }
    }
  }

  expect_failures = [var.domains]
}

run "rejects_bad_status" {
  command = plan

  variables {
    domains = {
      bad = {
        domain    = "example.com"
        soa_email = "admin@example.com"
        status    = "paused" # not active/disabled/edit_mode
      }
    }
  }

  expect_failures = [var.domains]
}

run "rejects_bad_tag" {
  command = plan

  variables {
    domains = {
      bad = {
        domain    = "example.com"
        soa_email = "admin@example.com"
        tags      = ["a"] # shorter than the 3-char minimum
      }
    }
  }

  expect_failures = [var.domains]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
