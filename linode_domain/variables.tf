variable "domains" {
  description = "Domain data."

  type = map(object({
    description = optional(string)
    domain      = string
    expire_sec  = number
    group       = optional(string)
    refresh_sec = number
    retry_sec   = number
    soa_email   = string
    status      = optional(string)
    tags        = optional(list(string))
    ttl_sec     = number
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
