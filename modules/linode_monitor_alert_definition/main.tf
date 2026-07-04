resource "linode_monitor_alert_definition" "this" {
  label        = var.label
  service_type = var.service_type
  severity     = var.severity
  channel_ids  = var.channel_ids

  description = var.description
  entity_ids  = var.entity_ids
  regions     = var.regions
  scope       = var.scope
  status      = var.status
  wait_for    = var.wait_for

  rule_criteria      = var.rule_criteria
  trigger_conditions = var.trigger_conditions
}
