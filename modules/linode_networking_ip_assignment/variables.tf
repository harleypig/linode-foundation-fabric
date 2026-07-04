variable "region" {
  description = "The region for the IP assignments."
  type        = string

  validation {
    condition = contains([
      "ap-west", "ca-central", "ap-southeast", "us-central", "us-west",
      "us-southeast", "us-east", "eu-west", "ap-south", "eu-central",
      "ap-northeast"
    ], var.region)
    error_message = "Region must be a valid Linode region."
  }
}

variable "assignments" {
  description = "The list of IP-to-Linode assignments to apply in the region. Each entry moves the given IP address to the specified Linode."
  type = list(object({
    address   = string
    linode_id = number
  }))
  default = []

  validation {
    condition     = alltrue([for a in var.assignments : length(a.address) > 0])
    error_message = "Each assignment address must be a non-empty IP address string."
  }

  validation {
    condition     = alltrue([for a in var.assignments : a.linode_id > 0])
    error_message = "Each assignment linode_id must be a positive integer."
  }
}
