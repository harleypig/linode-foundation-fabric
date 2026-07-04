variable "label" {
  description = "A label for the SSH key, for display purposes."
  type        = string

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 64
    error_message = "label must be 1-64 characters."
  }
}

variable "ssh_key" {
  description = "The public SSH key used to authenticate to the root user of deployed Linodes."
  type        = string

  validation {
    condition     = can(regex("^(ssh-rsa|ssh-ed25519|ssh-dss|ecdsa-sha2-nistp[0-9]+) ", var.ssh_key))
    error_message = "ssh_key must be a public key starting with a valid type (ssh-rsa, ssh-ed25519, ecdsa-sha2-nistp*, ssh-dss)."
  }
}
