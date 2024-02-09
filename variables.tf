variable "domains_raw" {
  description = "Raw domain data"
  type        = list(any)
}

variable "records" {
  description = "DNS records"
  type        = list(any)
}

variable "rdns" {
  description = "Reverse DNS entries"
  type        = list(any)
}
