variable "scopes" {
  description = "The scopes this token was created with. These define what parts of the Account the token can be used to access. Many command-line tools, such as the Linode CLI, require tokens with access to *. Tokens with more restrictive scopes are generally more secure. Multiple scopes are separated by a space character (e.g., \"databases:read_only events:read_only\")."
  type        = string

  validation {
    condition = can(regex(
      "^(\\*|[a-z_]+:(read_only|read_write))( (\\*|[a-z_]+:(read_only|read_write)))*$",
      var.scopes
    ))
    error_message = "Scopes must be a space-separated list of '<resource>:read_only' / '<resource>:read_write' entries, or '*' for full access."
  }
}

variable "label" {
  description = "The label of the Linode Token."
  type        = string
  default     = null

  validation {
    condition     = var.label == null || (length(coalesce(var.label, "")) >= 1 && length(coalesce(var.label, "")) <= 100)
    error_message = "Label must be between 1 and 100 characters long."
  }

  validation {
    condition     = var.label == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$", coalesce(var.label, "x")))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, underscores, and periods."
  }
}

variable "expiry" {
  description = "When this token will expire. Personal Access Tokens cannot be renewed, so after this time the token will be completely unusable and a new token will need to be generated. Tokens may be created with 'null' as their expiry and will never expire unless revoked. Format: 2006-01-02T15:04:05Z"
  type        = string
  default     = null

  validation {
    condition     = var.expiry == null || can(regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$", coalesce(var.expiry, "1970-01-01T00:00:00Z")))
    error_message = "Expiry must be a UTC timestamp in the format 2006-01-02T15:04:05Z (RFC 3339)."
  }
}
