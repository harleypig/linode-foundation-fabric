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
    condition = alltrue([
      for obj in var.records : obj.record_type != "SRV" || (obj.record_type == "SRV" && obj.name == null)
    ])
    error_message = "The name field must be null when the record_type is 'SRV'."
  }

  validation {
    condition = alltrue([
      for obj in var.records : obj.record_type != "SRV" || obj.protocol == null || (obj.record_type == "SRV" && obj.protocol != null)
    ])
    error_message = "The protocol field must be set only when the record_type is 'SRV'."
  }

  validation {
    condition = alltrue([
      for obj in var.records : obj.record_type != "SRV" || obj.service == null || (obj.record_type == "SRV" && obj.protocol != null)
    ])
    error_message = "The service field must be set only when the record_type is 'SRV'."
  }

  validation {
    condition = alltrue([
      for obj in var.records : obj.record_type == "CAA" || obj.tag == null || (obj.record_type == "CAA" && obj.tag != null)
    ])
    error_message = "The tag field must be set only when the record_type is 'CAA'."
  }

  validation {
    condition     = alltrue([for obj in values(var.records) : contains(["A", "AAAA", "NS", "MX", "CNAME", "TXT", "SRV", "PTR", "CAA"], obj.record_type)])
    error_message = "record_type must be one of: A, AAAA, NS, MX, CNAME, TXT, SRV, PTR, CAA."
  }

  validation {
    condition     = alltrue([for obj in values(var.records) : length(obj.target) > 0])
    error_message = "Each record target must be non-empty."
  }

  validation {
    condition     = alltrue([for obj in values(var.records) : obj.priority == null || (obj.priority >= 0 && obj.priority <= 255)])
    error_message = "priority, when set, must be between 0 and 255."
  }

  validation {
    condition     = alltrue([for obj in values(var.records) : obj.weight == null || (obj.weight >= 0 && obj.weight <= 65535)])
    error_message = "weight, when set, must be between 0 and 65535."
  }

  validation {
    condition     = alltrue([for obj in values(var.records) : obj.port == null || (obj.port >= 0 && obj.port <= 65535)])
    error_message = "port, when set, must be between 0 and 65535."
  }

  # ttl_sec is optional; null (omitted) is allowed, otherwise it must be one of
  # Linode's accepted intervals.
  validation {
    condition = alltrue([
      for obj in values(var.records) :
      obj.ttl_sec == null || contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.ttl_sec)
    ])
    error_message = "ttl_sec must be null or one of the valid Linode interval values."
  }
}
