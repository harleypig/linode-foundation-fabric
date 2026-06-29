variable "rdns" {
  description = "Reverse DNS entries"
  type = map(object({
    address = string
    rdns    = string
  }))

  validation {
    condition     = alltrue([for r in values(var.rdns) : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", r.address)) || can(regex("^[0-9A-Fa-f:]+$", r.address))])
    error_message = "Each rdns address must be a valid IPv4 or IPv6 address."
  }

  validation {
    condition     = alltrue([for r in values(var.rdns) : length(r.rdns) > 0 && can(regex("^[A-Za-z0-9.-]+$", r.rdns))])
    error_message = "Each rdns value must be a non-empty hostname (letters, digits, dots, hyphens)."
  }
}
