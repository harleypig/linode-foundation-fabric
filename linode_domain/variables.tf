variable "domains" {
  description = "Domain data."

  type = map(object({
    domain      = string
    soa_email   = string

    description = optional(string)
    expire_sec  = optional(number)
    group       = optional(string)
    refresh_sec = optional(number)
    retry_sec   = optional(number)
    status      = optional(string)
    tags        = optional(list(string))
    ttl_sec     = optional(number, description = "The Time To Live (TTL) for the domain, in seconds. Valid values are 0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200.")
  }))

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
        contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.ttl_sec)
    ])
    error_message = "The ttl_sec must be one of the specified valid values."
  }

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
        contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.retry_sec)
    ])
    error_message = "The retry_sec must be one of the specified valid values."
  }

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
        contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.expire_sec)
    ])
    error_message = "The expire_sec must be one of the specified valid values."
  }

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
        contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.refresh_sec)
    ])
    error_message = "The refresh_sec must be one of the specified valid values."
  }
}
