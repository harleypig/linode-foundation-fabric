# The protected module's own behaviour: once the instance exists, a change to
# a create-time attribute plans no change to it. The first run applies against
# the mock provider, which records an instance in the test's in-memory state
# and creates nothing real (no token, no API). Each later run is a plan
# against that state with one input changed. Run:
# terraform -chdir=modules/linode_instance_protected test
#
# The mock does not model the provider's ForceNew, so it never plans a
# replacement and prevent_destroy never fires here. What it does show is the
# planned value: an ignored attribute keeps the value in state, an attribute
# that is not ignored takes the new input. The replacement and its refusal are
# checked against the real provider by the README's manual procedure.
#
# terraform test's own teardown destroys the mock state without tripping
# prevent_destroy (observed on 1.14.0 and 1.15.9), so no cleanup override is
# needed; skip_cleanup is experimental-only.

mock_provider "linode" {
  mock_resource "linode_instance" {
    defaults = {
      ipv4 = ["198.51.100.10"]
    }
  }
}

variables {
  region           = "us-central"
  type             = "g6-standard-1"
  image            = "linode/ubuntu24.04"
  authorized_keys  = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBootstrapKeyOne bootstrap"]
  authorized_users = ["alice"]
  firewall_id      = 1001
  stackscript_id   = 2002
  stackscript_data = { role = "web" }
  metadata         = { user_data = "#cloud-config\ntimezone: UTC\n" }
}

run "create" {
  command = apply
}

run "user_data_change_plans_no_change" {
  command = plan

  variables {
    metadata = { user_data = "#cloud-config\ntimezone: America/Chicago\n" }
  }

  assert {
    condition     = linode_instance.instance.metadata[0].user_data == base64encode("#cloud-config\ntimezone: UTC\n")
    error_message = "a changed user_data must not reach the plan; the value in state should stand"
  }
}

run "authorized_keys_change_plans_no_change" {
  command = plan

  variables {
    authorized_keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBootstrapKeyOne bootstrap",
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIColleagueKeyTwo colleague",
    ]
  }

  assert {
    condition     = length(linode_instance.instance.authorized_keys) == 1
    error_message = "a changed authorized_keys must not reach the plan; the value in state should stand"
  }
}

run "authorized_users_change_plans_no_change" {
  command = plan

  variables {
    authorized_users = ["alice", "bob"]
  }

  assert {
    condition     = linode_instance.instance.authorized_users == tolist(["alice"])
    error_message = "a changed authorized_users must not reach the plan"
  }
}

run "image_change_plans_no_change" {
  command = plan

  variables {
    image = "linode/debian12"
  }

  assert {
    condition     = linode_instance.instance.image == "linode/ubuntu24.04"
    error_message = "a changed image must not reach the plan"
  }
}

run "stackscript_change_plans_no_change" {
  command = plan

  variables {
    stackscript_id   = 3003
    stackscript_data = { role = "db" }
  }

  assert {
    condition     = linode_instance.instance.stackscript_id == 2002
    error_message = "a changed stackscript_id must not reach the plan"
  }

  assert {
    condition     = nonsensitive(linode_instance.instance.stackscript_data["role"]) == "web"
    error_message = "a changed stackscript_data must not reach the plan"
  }
}

run "backup_id_change_plans_no_change" {
  command = plan

  # backup_id conflicts with image (and so with the StackScript inputs, which
  # require it), so this run swaps the deploy source wholesale.
  variables {
    image            = null
    stackscript_id   = null
    stackscript_data = null
    backup_id        = 4004
  }

  assert {
    condition     = linode_instance.instance.backup_id == null
    error_message = "a backup_id set after creation must not reach the plan"
  }
}

run "ipv4_change_plans_no_change" {
  command = plan

  variables {
    ipv4 = ["192.0.2.25"]
  }

  assert {
    condition     = linode_instance.instance.ipv4 == toset(["198.51.100.10"])
    error_message = "an ipv4 set after creation must not reach the plan"
  }
}

run "firewall_id_change_plans_no_change" {
  command = plan

  variables {
    firewall_id = 5005
  }

  assert {
    condition     = linode_instance.instance.firewall_id == 1001
    error_message = "a changed firewall_id must not reach the plan"
  }
}

# Control: the runs above would also pass if this test could not see a change
# at all. type is deliberately not ignored (a resize), so it must plan.
run "type_change_still_plans" {
  command = plan

  variables {
    type = "g6-standard-2"
  }

  assert {
    condition     = linode_instance.instance.type == "g6-standard-2"
    error_message = "type is not ignored; a resize must reach the plan"
  }
}

# root_pass is not ForceNew, but the provider applies a change with a power
# cycle (shutdown, reset, boot), so it is ignored like the create-time keys.
run "root_pass_change_plans_no_change" {
  command = plan

  variables {
    root_pass = "a-rotated-placeholder-Passw0rd"
  }

  assert {
    condition     = nonsensitive(linode_instance.instance.root_pass == null)
    error_message = "a root_pass set after creation must not reach the plan; it would power-cycle the server"
  }
}
