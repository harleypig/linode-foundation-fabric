variable "domains" {
  description = "Domain data."
  type = map(object({
    domain      = string
    soa_email   = string
    description = optional(string)
    expire_sec  = number
    group       = optional(string)
    refresh_sec = number
    retry_sec   = number
    tags        = optional(list(string))
    ttl_sec     = number
    status      = optional(string) # Optional status field for domain rendering
  }))
  default = {
    ttl_sec     = 0
    retry_sec   = 0
    expire_sec  = 0
    refresh_sec = 0
  }
  validation {
    condition     = contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], var.domains.ttl_sec)
    error_message = "The ttl_sec must be one of the specified valid values."
  }
  validation {
    condition     = contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], var.domains.retry_sec)
    error_message = "The retry_sec must be one of the specified valid values."
  }
  validation {
    condition     = contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], var.domains.expire_sec)
    error_message = "The expire_sec must be one of the specified valid values."
  }
  validation {
    condition     = contains([0, 30, 120, 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, 2419200], var.domains.refresh_sec)
    error_message = "The refresh_sec must be one of the specified valid values."
  }
}
