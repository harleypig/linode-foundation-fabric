variable "label" {
  description = "The StackScript's label is for display purposes only."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = length(var.label) >= 3 && length(var.label) <= 128
    error_message = "Label must be between 3 and 128 characters long."
  }
}

variable "description" {
  description = "A description for the StackScript."
  type        = string

  validation {
    condition     = length(var.description) >= 1
    error_message = "Description must not be empty."
  }
}

variable "images" {
  description = "An array of Image IDs representing the Images that this StackScript is compatible for deploying with."
  type        = set(string)

  validation {
    condition     = length(var.images) >= 1
    error_message = "At least one compatible Image ID must be specified."
  }

  validation {
    condition = alltrue([
      for image in var.images : can(regex("^[a-z0-9]+/[a-zA-Z0-9._-]+$", image))
    ])
    error_message = "Each image must be of the form '<vendor>/<image>' (e.g. 'linode/ubuntu22.04', 'any/all', 'private/12345')."
  }
}

variable "script" {
  description = "The script to execute when provisioning a new Linode with this StackScript."
  type        = string

  validation {
    condition     = can(regex("^#!", var.script))
    error_message = "Script must begin with a shebang line (e.g. '#!/bin/bash')."
  }
}

variable "is_public" {
  description = "This determines whether other users can use your StackScript. Once a StackScript is made public, it cannot be made private."
  type        = bool
  default     = false
}

variable "rev_note" {
  description = "This field allows you to add notes for the set of revisions made to this StackScript."
  type        = string
  default     = null
}
