# Plan-only tests for the linode_monitor_alert_definition module. command =
# plan never creates real infrastructure; mock_provider satisfies provider
# config so no Linode token is needed.
# Run: terraform -chdir=modules/linode_monitor_alert_definition test

mock_provider "linode" {}

variables {
  label        = "high-cpu-usage"
  service_type = "linode"
  severity     = 1
  channel_ids  = [12345]

  rule_criteria = {
    rules = [
      {
        aggregate_function = "avg"
        metric             = "cpu_usage"
        operator           = "gt"
        threshold          = 80
      }
    ]
  }

  trigger_conditions = {
    criteria_condition        = "ALL"
    evaluation_period_seconds = 300
    polling_interval_seconds  = 60
    trigger_occurrences       = 3
  }
}

run "valid_monitor_alert_definition_plans" {
  command = plan

  assert {
    condition     = linode_monitor_alert_definition.this.severity == 1
    error_message = "planned alert severity should match the input"
  }
}

run "rejects_empty_label" {
  command = plan

  variables {
    label = "" # must be at least 1 character
  }

  expect_failures = [var.label]
}

run "rejects_empty_service_type" {
  command = plan

  variables {
    service_type = "" # must be a non-empty string
  }

  expect_failures = [var.service_type]
}

run "rejects_invalid_severity" {
  command = plan

  variables {
    severity = 5 # not one of 0, 1, 2, 3
  }

  expect_failures = [var.severity]
}

run "rejects_empty_channel_ids" {
  command = plan

  variables {
    channel_ids = [] # at least one channel is required
  }

  expect_failures = [var.channel_ids]
}

run "rejects_empty_rules" {
  command = plan

  variables {
    rule_criteria = {
      rules = [] # must contain at least one rule
    }
  }

  expect_failures = [var.rule_criteria]
}

run "rejects_invalid_rule_operator" {
  command = plan

  variables {
    rule_criteria = {
      rules = [
        {
          operator = "xx" # not one of eq, gt, lt, gte, lte
        }
      ]
    }
  }

  expect_failures = [var.rule_criteria]
}

run "rejects_invalid_scope" {
  command = plan

  variables {
    scope = "global" # not one of account, entity, region
  }

  expect_failures = [var.scope]
}

run "rejects_negative_evaluation_period" {
  command = plan

  variables {
    trigger_conditions = {
      evaluation_period_seconds = -1 # must be positive when set
    }
  }

  expect_failures = [var.trigger_conditions]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
