variable "domains" {
  description = "Domain data."
  type = list(object({
    domain      = string
    soa_email   = string
    tags        = list(string)
    description = optional(string)
    group       = optional(string)
    ttl_sec     = optional(number)
    retry_sec   = optional(number)
    expire_sec  = optional(number)
    refresh_sec = optional(number)
    type        = string
  }))
}
