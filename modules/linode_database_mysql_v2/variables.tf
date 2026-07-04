variable "label" {
  description = "A unique, user-defined string referring to the Managed Database."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = length(var.label) >= 3 && length(var.label) <= 32
    error_message = "Label must be between 3 and 32 characters long."
  }
}

variable "engine_id" {
  description = "The unique ID of the database engine and version to use. (e.g. mysql/8)"
  type        = string

  validation {
    condition     = can(regex("^mysql/[0-9]+$", var.engine_id))
    error_message = "engine_id must be in engine/version format for MySQL (e.g. mysql/8)."
  }
}

variable "region" {
  description = "The Region ID for the Managed Database."
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

variable "type" {
  description = "The Linode Instance type used by the Managed Database for its nodes."
  type        = string

  validation {
    condition     = can(regex("^g[0-9]+-[a-z0-9-]+$", var.type))
    error_message = "type must be a valid Linode instance type (e.g. g6-nanode-1)."
  }
}

variable "allow_list" {
  description = "A list of IP addresses that can access the Managed Database. Each item can be a single IP address or a range in CIDR format."
  type        = set(string)
  default     = null
}

variable "cluster_size" {
  description = "The number of Linode instance nodes deployed to the Managed Database."
  type        = number
  default     = null

  validation {
    condition     = var.cluster_size == null || contains([1, 2, 3], coalesce(var.cluster_size, 1))
    error_message = "cluster_size must be 1, 2, or 3."
  }
}

variable "suspended" {
  description = "Whether this database is suspended."
  type        = bool
  default     = null
}

variable "fork_source" {
  description = "The ID of the database that was forked from."
  type        = number
  default     = null

  validation {
    condition     = var.fork_source == null || coalesce(var.fork_source, 1) > 0
    error_message = "fork_source must be a positive integer when specified."
  }
}

variable "fork_restore_time" {
  description = "The database timestamp from which it was restored."
  type        = string
  default     = null
}

variable "engine_config_binlog_retention_period" {
  description = "The minimum amount of time in seconds to keep binlog entries before deletion. This may be extended for services that require binlog entries for longer than the default for example if using the MySQL Debezium Kafka connector."
  type        = number
  default     = null
}

variable "engine_config_mysql_connect_timeout" {
  description = "The number of seconds that the mysqld server waits for a connect packet before responding with Bad handshake."
  type        = number
  default     = null
}

variable "engine_config_mysql_default_time_zone" {
  description = "Default server time zone as an offset from UTC (from -12:00 to +12:00), a time zone name, or 'SYSTEM' to use the MySQL server default."
  type        = string
  default     = null
}

variable "engine_config_mysql_group_concat_max_len" {
  description = "The maximum permitted result length in bytes for the GROUP_CONCAT() function."
  type        = number
  default     = null
}

variable "engine_config_mysql_information_schema_stats_expiry" {
  description = "The time, in seconds, before cached statistics expire."
  type        = number
  default     = null
}

variable "engine_config_mysql_innodb_change_buffer_max_size" {
  description = "Maximum size for the InnoDB change buffer, as a percentage of the total size of the buffer pool. Default is 25."
  type        = number
  default     = null

  validation {
    condition     = var.engine_config_mysql_innodb_change_buffer_max_size == null || (coalesce(var.engine_config_mysql_innodb_change_buffer_max_size, 25) >= 0 && coalesce(var.engine_config_mysql_innodb_change_buffer_max_size, 25) <= 100)
    error_message = "engine_config_mysql_innodb_change_buffer_max_size must be a percentage between 0 and 100."
  }
}

variable "engine_config_mysql_innodb_flush_neighbors" {
  description = "Specifies whether flushing a page from the InnoDB buffer pool also flushes other dirty pages in the same extent (default is 1): 0 - dirty pages in the same extent are not flushed, 1 - flush contiguous dirty pages in the same extent, 2 - flush dirty pages in the same extent."
  type        = number
  default     = null

  validation {
    condition     = var.engine_config_mysql_innodb_flush_neighbors == null || contains([0, 1, 2], coalesce(var.engine_config_mysql_innodb_flush_neighbors, 1))
    error_message = "engine_config_mysql_innodb_flush_neighbors must be 0, 1, or 2."
  }
}

variable "engine_config_mysql_innodb_ft_min_token_size" {
  description = "Minimum length of words that are stored in an InnoDB FULLTEXT index. Changing this parameter will lead to a restart of the MySQL service."
  type        = number
  default     = null
}

variable "engine_config_mysql_innodb_ft_server_stopword_table" {
  description = "This option is used to specify your own InnoDB FULLTEXT index stopword list for all InnoDB tables."
  type        = string
  default     = null
}

variable "engine_config_mysql_innodb_lock_wait_timeout" {
  description = "The length of time in seconds an InnoDB transaction waits for a row lock before giving up. Default is 120."
  type        = number
  default     = null
}

variable "engine_config_mysql_innodb_log_buffer_size" {
  description = "The size in bytes of the buffer that InnoDB uses to write to the log files on disk."
  type        = number
  default     = null
}

variable "engine_config_mysql_innodb_online_alter_log_max_size" {
  description = "The upper limit in bytes on the size of the temporary log files used during online DDL operations for InnoDB tables."
  type        = number
  default     = null
}

variable "engine_config_mysql_innodb_read_io_threads" {
  description = "The number of I/O threads for read operations in InnoDB. Default is 4. Changing this parameter will lead to a restart of the MySQL service."
  type        = number
  default     = null
}

variable "engine_config_mysql_innodb_rollback_on_timeout" {
  description = "When enabled a transaction timeout causes InnoDB to abort and roll back the entire transaction. Changing this parameter will lead to a restart of the MySQL service."
  type        = bool
  default     = null
}

variable "engine_config_mysql_innodb_thread_concurrency" {
  description = "Defines the maximum number of threads permitted inside of InnoDB. Default is 0 (infinite concurrency - no limit)."
  type        = number
  default     = null
}

variable "engine_config_mysql_innodb_write_io_threads" {
  description = "The number of I/O threads for write operations in InnoDB. Default is 4. Changing this parameter will lead to a restart of the MySQL service."
  type        = number
  default     = null
}

variable "engine_config_mysql_interactive_timeout" {
  description = "The number of seconds the server waits for activity on an interactive connection before closing it."
  type        = number
  default     = null
}

variable "engine_config_mysql_internal_tmp_mem_storage_engine" {
  description = "The storage engine for in-memory internal temporary tables."
  type        = string
  default     = null
}

variable "engine_config_mysql_max_allowed_packet" {
  description = "Size of the largest message in bytes that can be received by the server. Default is 67108864 (64M)."
  type        = number
  default     = null
}

variable "engine_config_mysql_max_heap_table_size" {
  description = "Limits the size of internal in-memory tables. Also set tmp_table_size. Default is 16777216 (16M)."
  type        = number
  default     = null
}

variable "engine_config_mysql_net_buffer_length" {
  description = "Start sizes of connection buffer and result buffer. Default is 16384 (16K). Changing this parameter will lead to a restart of the MySQL service."
  type        = number
  default     = null
}

variable "engine_config_mysql_net_read_timeout" {
  description = "The number of seconds to wait for more data from a connection before aborting the read."
  type        = number
  default     = null
}

variable "engine_config_mysql_net_write_timeout" {
  description = "The number of seconds to wait for a block to be written to a connection before aborting the write."
  type        = number
  default     = null
}

variable "engine_config_mysql_sort_buffer_size" {
  description = "Sort buffer size in bytes for ORDER BY optimization. Default is 262144 (256K)."
  type        = number
  default     = null
}

variable "engine_config_mysql_sql_mode" {
  description = "Global SQL mode. Set to empty to use MySQL server defaults. When creating a new service and not setting this field Aiven default SQL mode (strict, SQL standard compliant) will be assigned."
  type        = string
  default     = null
}

variable "engine_config_mysql_sql_require_primary_key" {
  description = "Require primary key to be defined for new tables or old tables modified with ALTER TABLE and fail if missing. It is recommended to always have primary keys because various functionality may break if any large table is missing them."
  type        = bool
  default     = null
}

variable "engine_config_mysql_tmp_table_size" {
  description = "Limits the size of internal in-memory tables. Also set max_heap_table_size. Default is 16777216 (16M)."
  type        = number
  default     = null
}

variable "engine_config_mysql_wait_timeout" {
  description = "The number of seconds the server waits for activity on a noninteractive connection before closing it."
  type        = number
  default     = null
}

variable "private_network" {
  description = "Restricts access to this database using a virtual private cloud (VPC) that you've configured in the region where the database will live."
  type = object({
    public_access = optional(bool)
    subnet_id     = number
    vpc_id        = number
  })
  default = null

  validation {
    condition     = var.private_network == null || (coalesce(try(var.private_network.subnet_id, 0), 0) > 0 && coalesce(try(var.private_network.vpc_id, 0), 0) > 0)
    error_message = "private_network subnet_id and vpc_id must be positive integers."
  }
}

variable "updates" {
  description = "Configuration settings for automated patch update maintenance for the Managed Database."
  type = object({
    day_of_week = optional(number)
    duration    = optional(number)
    frequency   = optional(string)
    hour_of_day = optional(number)
  })
  default = null

  validation {
    condition     = var.updates == null || var.updates.day_of_week == null || (var.updates.day_of_week >= 1 && var.updates.day_of_week <= 7)
    error_message = "updates.day_of_week must be between 1 (Monday) and 7 (Sunday)."
  }

  validation {
    condition     = var.updates == null || var.updates.hour_of_day == null || (var.updates.hour_of_day >= 0 && var.updates.hour_of_day <= 23)
    error_message = "updates.hour_of_day must be between 0 and 23."
  }

  validation {
    condition     = var.updates == null || var.updates.frequency == null || var.updates.frequency == "weekly"
    error_message = "updates.frequency can only be weekly."
  }
}

variable "timeouts" {
  description = "The timeouts configuration for the Linode Managed Database."
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null

  validation {
    condition = var.timeouts == null || alltrue([
      for timeout in values(var.timeouts) : timeout == null || can(regex("^[0-9]+[smh]$", timeout))
    ])
    error_message = "Timeout values must be in the format of number followed by 's' (seconds), 'm' (minutes), or 'h' (hours)."
  }
}
