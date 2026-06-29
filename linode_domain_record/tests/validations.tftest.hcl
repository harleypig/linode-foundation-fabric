# Plan-only tests for the linode_domain_record module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed (variable validations run regardless of provider —
# see DEVELOPER.md / the repo QA doc). Run: terraform -chdir=tfmods/linode_domain_record test

mock_provider "linode" {}

variables {
  records = {
    www = {
      domain_id   = 123
      record_type = "A"
      target      = "192.0.2.1"
      name        = "www"
      ttl_sec     = 300
    }
  }
}

run "valid_record_plans" {
  command = plan

  assert {
    condition     = length(linode_domain_record.domain_records) == 1
    error_message = "expected exactly one planned domain record"
  }
}

run "rejects_invalid_ttl" {
  command = plan

  variables {
    records = {
      bad = {
        domain_id   = 123
        record_type = "A"
        target      = "192.0.2.1"
        ttl_sec     = 999 # not in the allowed ttl_sec set
      }
    }
  }

  expect_failures = [var.records]
}

run "rejects_srv_with_name" {
  command = plan

  variables {
    records = {
      bad = {
        domain_id   = 123
        record_type = "SRV"
        target      = "10 5 5060 sip.example.com"
        name        = "_sip" # name must be null for SRV records
        ttl_sec     = 300
      }
    }
  }

  expect_failures = [var.records]
}
