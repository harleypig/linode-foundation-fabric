# Plan-only tests for the optional create-time `ipv4` input. command = plan
# never creates real infrastructure; mock_provider satisfies provider config so
# no Linode token is needed. Run: terraform -chdir=modules/linode_instance test
#
# `ipv4` is Optional + Computed on the provider side. The mock supplies a
# computed value at plan time (override_during = plan), so the planned value
# tells the two paths apart: unset, the provider's computed value stands
# (the module sent nothing); set, the configured addresses win.

mock_provider "linode" {
  override_during = plan

  mock_resource "linode_instance" {
    defaults = {
      ipv4 = ["198.51.100.10"]
    }
  }
}

variables {
  region = "us-central"
  type   = "g6-standard-1"
  image  = "linode/ubuntu22.04"
}

run "ipv4_unset_leaves_address_to_linode" {
  command = plan

  assert {
    condition     = var.ipv4 == null
    error_message = "ipv4 should default to null"
  }

  assert {
    condition     = linode_instance.instance.ipv4 == toset(["198.51.100.10"])
    error_message = "with ipv4 unset the module must not send an address; the provider-computed value should stand"
  }
}

run "ipv4_set_passes_reserved_address_through" {
  command = plan

  variables {
    ipv4 = ["192.0.2.25"]
  }

  assert {
    condition     = linode_instance.instance.ipv4 == toset(["192.0.2.25"])
    error_message = "the configured reserved address should be planned as the instance's ipv4"
  }
}

run "rejects_non_ipv4_address" {
  command = plan

  variables {
    ipv4 = ["2001:db8::1"] # IPv6 is not accepted here
  }

  expect_failures = [var.ipv4]
}

run "rejects_malformed_address" {
  command = plan

  variables {
    ipv4 = ["192.0.2.300"]
  }

  expect_failures = [var.ipv4]
}

run "rejects_cidr_notation" {
  command = plan

  variables {
    ipv4 = ["192.0.2.25/32"] # a bare address, not a range
  }

  expect_failures = [var.ipv4]
}
