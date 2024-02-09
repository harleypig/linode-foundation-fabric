variable "records" {
  description = "DNS records"
  type = map(object({
    domain_index = string
    record_type  = string
    target       = string
    name         = optional(string)
    ttl_sec      = optional(number)
    priority     = optional(number)
    protocol     = optional(string)
    service      = optional(string)
    tag          = optional(string)
    port         = optional(number)
    weight       = optional(number)
  }))
}
