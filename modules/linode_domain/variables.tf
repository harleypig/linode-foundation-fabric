variable "domains" {
  description = "Domain data."

  type = map(object({
    domain    = string
    soa_email = string

    description = optional(string)
    expire_sec  = optional(number)
    refresh_sec = optional(number)
    retry_sec   = optional(number)
    status      = optional(string)
    tags        = optional(list(string))
    ttl_sec     = optional(number)
  }))

  validation {
    condition     = alltrue([for obj in values(var.domains) : can(regex("^[a-zA-Z0-9][a-zA-Z0-9.-]*\\.[a-zA-Z]{2,}$", obj.domain))])
    error_message = "Each domain must be a valid fully-qualified domain name."
  }

  validation {
    condition     = alltrue([for obj in values(var.domains) : can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", obj.soa_email))])
    error_message = "Each soa_email must be a valid email address."
  }

  validation {
    condition     = alltrue([for obj in values(var.domains) : obj.status == null || contains(["active", "disabled", "edit_mode"], obj.status)])
    error_message = "status, when set, must be one of: active, disabled, edit_mode."
  }

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
      obj.tags == null || alltrue([for t in obj.tags : can(regex("^[a-zA-Z0-9:_-]+$", t)) && length(t) >= 3 && length(t) <= 50])
    ])
    error_message = "Each tag must be 3-50 characters and contain only alphanumeric characters, colons, hyphens, and underscores."
  }

  # ttl_sec / retry_sec / expire_sec / refresh_sec are optional; null (omitted)
  # is allowed, otherwise the value must be one of Linode's accepted intervals.
  validation {
    condition = alltrue([
      for obj in values(var.domains) :
      obj.ttl_sec == null || contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.ttl_sec)
    ])
    error_message = "ttl_sec must be null or one of the valid Linode interval values."
  }

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
      obj.retry_sec == null || contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.retry_sec)
    ])
    error_message = "retry_sec must be null or one of the valid Linode interval values."
  }

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
      obj.expire_sec == null || contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.expire_sec)
    ])
    error_message = "expire_sec must be null or one of the valid Linode interval values."
  }

  validation {
    condition = alltrue([
      for obj in values(var.domains) :
      obj.refresh_sec == null || contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], obj.refresh_sec)
    ])
    error_message = "refresh_sec must be null or one of the valid Linode interval values."
  }
}
