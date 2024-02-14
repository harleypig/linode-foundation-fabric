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
      for obj in var.records : obj.record_type != "SRV" || (obj.record_type == "SRV" && obj.name != null)
    ])
    error_message = "The name field must be set when the record_type is 'SRV'."
  }
  #validation {
  #  condition     = alltrue([
  #    for obj in var.records : obj.record_type == "SRV" && obj.name != null
  #  ])
  #  error_message = "The name field must not be set when the record_type is 'SRV'."
  #}
}
