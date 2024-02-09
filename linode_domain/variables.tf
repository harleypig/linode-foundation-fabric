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
    tags        = optional(list(string))
    ttl_sec     = optional(number)
  }))
}
