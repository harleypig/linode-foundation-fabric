variable "rdns" {
  description = "Reverse DNS entries"
  type = map(object({
    address = string
    rdns    = string
    wait    = optional(bool)
    imported = optional(bool) # Indicates if the RDNS entry has been imported
  }))
}
