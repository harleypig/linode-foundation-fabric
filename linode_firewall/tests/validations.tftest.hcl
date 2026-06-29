# Plan-only tests for the linode_firewall module. command = plan never creates
# real infrastructure; mock_provider satisfies provider config so no Linode
# token is needed. Run: terraform -chdir=tfmods/linode_firewall test

mock_provider "linode" {}

variables {
  label = "test-firewall"
  inbound = [{
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }]
}

run "valid_firewall_plans" {
  command = plan

  assert {
    condition     = linode_firewall.this.inbound_policy == "DROP"
    error_message = "inbound_policy should default to DROP (least-privilege)"
  }

  assert {
    condition     = linode_firewall.this.outbound_policy == "ACCEPT"
    error_message = "outbound_policy should default to ACCEPT"
  }

  assert {
    condition     = length(linode_firewall.this.inbound) == 1
    error_message = "expected exactly one planned inbound rule"
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

run "rejects_invalid_inbound_policy" {
  command = plan

  variables {
    inbound_policy = "MAYBE" # only ACCEPT or DROP
  }

  expect_failures = [var.inbound_policy]
}

run "rejects_invalid_outbound_policy" {
  command = plan

  variables {
    outbound_policy = "MAYBE" # only ACCEPT or DROP
  }

  expect_failures = [var.outbound_policy]
}

run "rejects_invalid_rule_action" {
  command = plan

  variables {
    inbound = [{
      label    = "bad-action"
      action   = "MAYBE" # only ACCEPT or DROP
      protocol = "TCP"
      ports    = "80"
    }]
  }

  expect_failures = [var.inbound]
}

run "rejects_invalid_rule_protocol" {
  command = plan

  variables {
    inbound = [{
      label    = "bad-protocol"
      action   = "ACCEPT"
      protocol = "SCTP" # only TCP, UDP, ICMP
      ports    = "80"
    }]
  }

  expect_failures = [var.inbound]
}

run "rejects_icmp_with_ports" {
  command = plan

  variables {
    inbound = [{
      label    = "icmp-with-ports"
      action   = "ACCEPT"
      protocol = "ICMP"
      ports    = "80" # ICMP rules must not specify ports
    }]
  }

  expect_failures = [var.inbound]
}

run "rejects_negative_linode_id" {
  command = plan

  variables {
    linodes = [-1] # must be positive
  }

  expect_failures = [var.linodes]
}

run "rejects_bad_tag" {
  command = plan

  variables {
    tags = ["ok", "a"] # "a" is shorter than the 3-char minimum
  }

  expect_failures = [var.tags]
}
