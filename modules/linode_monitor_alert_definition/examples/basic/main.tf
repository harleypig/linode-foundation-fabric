# Basic usage of the linode_monitor_alert_definition module. This example
# doubles as a plan-only test fixture: tests/validations.tftest.hcl plans it
# under a mock provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "monitor_alert_definition" {
  source = "../.."

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
