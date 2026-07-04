variable "label" {
  description = "The name of the alert definition."
  type        = string

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 100
    error_message = "Label must be between 1 and 100 characters long."
  }
}

variable "service_type" {
  description = "The Akamai Cloud Computing service being monitored."
  type        = string

  validation {
    condition     = length(var.service_type) >= 1
    error_message = "service_type must be a non-empty string."
  }
}

variable "severity" {
  description = "The severity of the alert. Supported values: 3 for info, 2 for low, 1 for medium, 0 for severe."
  type        = number

  validation {
    condition     = contains([0, 1, 2, 3], var.severity)
    error_message = "severity must be one of 0 (severe), 1 (medium), 2 (low), or 3 (info)."
  }
}

variable "channel_ids" {
  description = "The identifiers for the alert channels to use for the alert."
  type        = list(number)

  validation {
    condition     = length(var.channel_ids) >= 1
    error_message = "At least one alert channel id must be provided."
  }
}

variable "rule_criteria" {
  description = "Details for the rules required to trigger the alert."
  type = object({
    rules = list(object({
      aggregate_function = optional(string)
      metric             = optional(string)
      operator           = optional(string)
      threshold          = optional(number)
      dimension_filters = optional(list(object({
        dimension_label = optional(string)
        operator        = optional(string)
        value           = optional(string)
      })))
    }))
  })

  validation {
    condition     = length(var.rule_criteria.rules) >= 1
    error_message = "rule_criteria.rules must contain at least one rule."
  }

  validation {
    condition = alltrue([
      for r in var.rule_criteria.rules :
      r.operator == null || contains(["eq", "gt", "lt", "gte", "lte"], r.operator)
    ])
    error_message = "Each rule operator must be one of eq, gt, lt, gte, lte."
  }
}

variable "trigger_conditions" {
  description = "The conditions that need to be met to send a notification for the alert."
  type = object({
    criteria_condition        = optional(string)
    evaluation_period_seconds = optional(number)
    polling_interval_seconds  = optional(number)
    trigger_occurrences       = optional(number)
  })

  validation {
    condition = (
      var.trigger_conditions.evaluation_period_seconds == null ||
      var.trigger_conditions.evaluation_period_seconds > 0
    )
    error_message = "evaluation_period_seconds must be a positive number when specified."
  }

  validation {
    condition = (
      var.trigger_conditions.polling_interval_seconds == null ||
      var.trigger_conditions.polling_interval_seconds > 0
    )
    error_message = "polling_interval_seconds must be a positive number when specified."
  }
}

variable "entity_ids" {
  description = "The id for each individual entity from a service_type."
  type        = list(string)
  default     = null
}

variable "regions" {
  description = "The regions the alert definition applies to. Only used for region-scoped alerts."
  type        = list(string)
  default     = null
}

variable "scope" {
  description = "The scope of the alert definition. Allowed values: account, entity, region. Defaults to entity."
  type        = string
  default     = null

  validation {
    condition     = var.scope == null || contains(["account", "entity", "region"], var.scope)
    error_message = "scope must be one of account, entity, or region."
  }
}

variable "description" {
  description = "An additional description for the alert definition."
  type        = string
  default     = null
}

variable "status" {
  description = "The current status of the alert."
  type        = string
  default     = null
}

variable "wait_for" {
  description = "Wait for the alert definition ready (not in progress)."
  type        = bool
  default     = null
}
