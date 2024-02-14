variable "records" {
  description = "DNS records"
  type = map(object({
    domain_id   = number
    record_type = string
    target      = string
    name        = optional(string)
    ttl_sec     = optional(number)
    priority    = optional(number)
    protocol    = optional(string)
    service     = optional(string)
    tag         = optional(string)
    port        = optional(number)
    weight      = optional(number)
  }))

  validation {
    condition     = alltrue([
      for obj in var.records : obj.record_type != "SRV" || (obj.record_type == "SRV" && obj.name == null)
    ])
    error_message = "The name field must be null when the record_type is 'SRV'."
  }

  validation {
    condition     = alltrue([
      for obj in var.records : obj.record_type != "SRV" || (obj.record_type == "SRV" && obj.protocol != null)
    ])
    error_message = "The protocol field must not be null when the record_type is 'SRV'."
  }

  validation {
    condition     = alltrue([
      for obj in var.records : obj.record_type != "SRV" || (obj.record_type == "SRV" && obj.service != null)
    ])
    error_message = "The service field must not be null when the record_type is 'SRV'."
  }

  validation {
    condition = alltrue([
      for obj in values(var.records) :
        contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.ttl_sec)
    ])
    error_message = "The ttl_sec must be one of the specified valid values."
  }
}
