# NOTE: Object Storage region IDs use the cluster style (e.g. us-east-1,
# eu-central-1) and differ from compute region IDs (us-east). The value here
# must match the bucket's S3 endpoint host (us-east-1 -> us-east-1.linodeobjects.com).
variable "region" {
  description = "The Object Storage region (cluster) the bucket lives in, e.g. us-east-1."
  type        = string

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+(-[0-9]+)?$", var.region))
    error_message = "Region must look like an Object Storage region/cluster id, e.g. us-east-1 or eu-central-1."
  }
}

variable "label" {
  description = "The globally-unique name (label) of the bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.label))
    error_message = "Bucket label must be 3-63 chars: lowercase letters, digits, dots, or hyphens, starting and ending alphanumeric (S3 bucket naming)."
  }
}
