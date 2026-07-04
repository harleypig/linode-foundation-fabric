# Linode Monitor Alert Definition Terraform Module

This module manages a single `linode_monitor_alert_definition` — a user alert
in Akamai Cloud Manager that evaluates one or more metric rules for a service
and notifies the configured alert channels when the trigger conditions are
met.

## Usage

```hcl
module "monitor_alert_definition" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_monitor_alert_definition?ref=v2.0.0"

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
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_monitor_alert_definition.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/monitor_alert_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_channel_ids"></a> [channel\_ids](#input\_channel\_ids) | The identifiers for the alert channels to use for the alert. | `list(number)` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | The name of the alert definition. | `string` | n/a | yes |
| <a name="input_rule_criteria"></a> [rule\_criteria](#input\_rule\_criteria) | Details for the rules required to trigger the alert. | <pre>object({<br/>    rules = list(object({<br/>      aggregate_function = optional(string)<br/>      metric             = optional(string)<br/>      operator           = optional(string)<br/>      threshold          = optional(number)<br/>      dimension_filters = optional(list(object({<br/>        dimension_label = optional(string)<br/>        operator        = optional(string)<br/>        value           = optional(string)<br/>      })))<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_service_type"></a> [service\_type](#input\_service\_type) | The Akamai Cloud Computing service being monitored. | `string` | n/a | yes |
| <a name="input_severity"></a> [severity](#input\_severity) | The severity of the alert. Supported values: 3 for info, 2 for low, 1 for medium, 0 for severe. | `number` | n/a | yes |
| <a name="input_trigger_conditions"></a> [trigger\_conditions](#input\_trigger\_conditions) | The conditions that need to be met to send a notification for the alert. | <pre>object({<br/>    criteria_condition        = optional(string)<br/>    evaluation_period_seconds = optional(number)<br/>    polling_interval_seconds  = optional(number)<br/>    trigger_occurrences       = optional(number)<br/>  })</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | An additional description for the alert definition. | `string` | `null` | no |
| <a name="input_entity_ids"></a> [entity\_ids](#input\_entity\_ids) | The id for each individual entity from a service\_type. | `list(string)` | `null` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | The regions the alert definition applies to. Only used for region-scoped alerts. | `list(string)` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope of the alert definition. Allowed values: account, entity, region. Defaults to entity. | `string` | `null` | no |
| <a name="input_status"></a> [status](#input\_status) | The current status of the alert. | `string` | `null` | no |
| <a name="input_wait_for"></a> [wait\_for](#input\_wait\_for) | Wait for the alert definition ready (not in progress). | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alert_channels"></a> [alert\_channels](#output\_alert\_channels) | The alert channels set up for use with this alert. |
| <a name="output_class"></a> [class](#output\_class) | The plan type for the Managed Database cluster (only for dbaas system alerts; null otherwise). |
| <a name="output_created"></a> [created](#output\_created) | When this Alert Definition was created. |
| <a name="output_created_by"></a> [created\_by](#output\_created\_by) | The user that created the alert definition, or system for a system alert definition. |
| <a name="output_entities"></a> [entities](#output\_entities) | Entity metadata for the alert definition. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier assigned to the alert definition. |
| <a name="output_status"></a> [status](#output\_status) | The current status of the alert. |
| <a name="output_type"></a> [type](#output\_type) | The type of alert, either user (specific to the current user) or system (applies to all users on the account). |
| <a name="output_updated"></a> [updated](#output\_updated) | When this Alert Definition was last updated. |
| <a name="output_updated_by"></a> [updated\_by](#output\_updated\_by) | The user that last updated the alert definition, or system for a system alert definition. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `severity` is inverted from intuition: `0` is the most severe and `3` is
  informational (3 info, 2 low, 1 medium, 0 severe).
- `channel_ids` reference existing alert channels on the account; run the
  provider's List alert channels operation to discover their ids. The
  read-only `alert_channels` output returns the resolved channel details.
- Several rule and dimension-filter fields (`label`, `unit`, and the channel
  metadata) are computed by the API and surfaced only through outputs, not as
  inputs.
- `scope` defaults to `entity` on the API side when omitted; set `regions`
  only for a region-scoped alert.
