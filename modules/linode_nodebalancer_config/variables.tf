variable "nodebalancer_id" {
  description = "The ID of the NodeBalancer to access."
  type        = number

  validation {
    condition     = var.nodebalancer_id > 0
    error_message = "NodeBalancer ID must be a positive integer."
  }
}

variable "port" {
  description = "The TCP port this Config is for. These values must be unique across configs on a single NodeBalancer (you can't have two configs for port 80, for example). While some ports imply some protocols, no enforcement is done and you may configure your NodeBalancer however is useful to you. For example, while port 443 is generally used for HTTPS, you do not need SSL configured to have a NodeBalancer listening on port 443."
  type        = number
  default     = null

  validation {
    condition     = var.port == null || (var.port >= 1 && var.port <= 65535)
    error_message = "Port must be between 1 and 65535."
  }
}

variable "protocol" {
  description = "The protocol this port is configured to serve. If this is set to https you must include an ssl_cert and an ssl_key."
  type        = string
  default     = null

  validation {
    condition     = var.protocol == null || contains(["tcp", "http", "https"], var.protocol)
    error_message = "Protocol must be one of tcp, http, or https."
  }
}

variable "proxy_protocol" {
  description = "The version of ProxyProtocol to use for the underlying NodeBalancer. This requires protocol to be `tcp`. Valid values are `none`, `v1`, and `v2`."
  type        = string
  default     = null

  validation {
    condition     = var.proxy_protocol == null || contains(["none", "v1", "v2"], var.proxy_protocol)
    error_message = "proxy_protocol must be one of none, v1, or v2."
  }
}

variable "algorithm" {
  description = "What algorithm this NodeBalancer should use for routing traffic to backends: roundrobin, leastconn, source."
  type        = string
  default     = null

  validation {
    condition     = var.algorithm == null || contains(["roundrobin", "leastconn", "source"], var.algorithm)
    error_message = "Algorithm must be one of roundrobin, leastconn, or source."
  }
}

variable "stickiness" {
  description = "Controls how session stickiness is handled on this port: 'none', 'table', 'http_cookie'."
  type        = string
  default     = null

  validation {
    condition     = var.stickiness == null || contains(["none", "table", "http_cookie"], var.stickiness)
    error_message = "Stickiness must be one of none, table, or http_cookie."
  }
}

variable "check" {
  description = "The type of check to perform against backends to ensure they are serving requests. This is used to determine if backends are up or down. If none no check is performed. connection requires only a connection to the backend to succeed. http and http_body rely on the backend serving HTTP, and that the response returned matches what is expected."
  type        = string
  default     = null

  validation {
    condition     = var.check == null || contains(["none", "connection", "http", "http_body"], var.check)
    error_message = "Check must be one of none, connection, http, or http_body."
  }
}

variable "check_interval" {
  description = "How often, in seconds, to check that backends are up and serving requests."
  type        = number
  default     = null

  validation {
    condition     = var.check_interval == null || var.check_interval >= 0
    error_message = "check_interval must be a non-negative number of seconds."
  }
}

variable "check_timeout" {
  description = "How long, in seconds, to wait for a check attempt before considering it failed. (1-30)"
  type        = number
  default     = null

  validation {
    condition     = var.check_timeout == null || (var.check_timeout >= 1 && var.check_timeout <= 30)
    error_message = "check_timeout must be between 1 and 30 seconds."
  }
}

variable "check_attempts" {
  description = "How many times to attempt a check before considering a backend to be down. (1-30)"
  type        = number
  default     = null

  validation {
    condition     = var.check_attempts == null || (var.check_attempts >= 1 && var.check_attempts <= 30)
    error_message = "check_attempts must be between 1 and 30."
  }
}

variable "check_path" {
  description = "The URL path to check on each backend. If the backend does not respond to this request it is considered to be down."
  type        = string
  default     = null
}

variable "check_body" {
  description = "This value must be present in the response body of the check in order for it to pass. If this value is not present in the response body of a check request, the backend is considered to be down."
  type        = string
  default     = null
}

variable "check_passive" {
  description = "If true, any response from this backend with a 5xx status code will be enough for it to be considered unhealthy and taken out of rotation."
  type        = bool
  default     = null
}

variable "cipher_suite" {
  description = "What ciphers to use for SSL connections served by this NodeBalancer. `legacy` is considered insecure and should only be used if necessary."
  type        = string
  default     = null

  validation {
    condition     = var.cipher_suite == null || contains(["recommended", "legacy"], var.cipher_suite)
    error_message = "cipher_suite must be one of recommended or legacy."
  }
}

variable "ssl_cert" {
  description = "The certificate this port is serving. This is not returned. If set, this field will come back as `<REDACTED>`. Please use the ssl_commonname and ssl_fingerprint to identify the certificate."
  type        = string
  default     = null
  sensitive   = true
}

variable "ssl_key" {
  description = "The private key corresponding to this port's certificate. This is not returned. If set, this field will come back as `<REDACTED>`. Please use the ssl_commonname and ssl_fingerprint to identify the certificate."
  type        = string
  default     = null
  sensitive   = true
}

variable "udp_check_port" {
  description = "Specifies the port on the backend node used for active health checks, which may differ from the port serving traffic."
  type        = number
  default     = null

  validation {
    condition     = var.udp_check_port == null || (var.udp_check_port >= 1 && var.udp_check_port <= 65535)
    error_message = "udp_check_port must be between 1 and 65535."
  }
}
