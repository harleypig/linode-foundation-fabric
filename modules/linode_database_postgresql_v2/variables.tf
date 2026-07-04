variable "engine_id" {
  description = "The unique ID of the database engine and version to use. (e.g. postgresql/16)"
  type        = string

  validation {
    condition     = can(regex("^postgresql/[0-9]+$", var.engine_id))
    error_message = "engine_id must be in engine/version format for PostgreSQL (e.g. postgresql/16)."
  }
}

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
    condition     = can(regex("^g[0-9]-", var.type))
    error_message = "type must be a valid Linode instance type (e.g. g6-nanode-1)."
  }
}

variable "allow_list" {
  description = "A list of IP addresses that can access the Managed Database. Each item can be a single IP address or a range in CIDR format."
  type        = set(string)
  default     = null

  validation {
    condition = var.allow_list == null || alltrue([
      for ip in coalesce(var.allow_list, []) :
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(/[0-9]{1,2})?$", ip)) ||
      can(regex("^[0-9a-fA-F:]+(/[0-9]{1,3})?$", ip))
    ])
    error_message = "Each allow_list entry must be a valid IPv4/IPv6 address or CIDR range."
  }
}

variable "cluster_size" {
  description = "The number of Linode instance nodes deployed to the Managed Database."
  type        = number
  default     = null

  validation {
    condition     = var.cluster_size == null || contains([1, 2, 3], var.cluster_size)
    error_message = "cluster_size must be 1, 2, or 3 when specified."
  }
}

variable "fork_source" {
  description = "The ID of the database that was forked from."
  type        = number
  default     = null

  validation {
    condition     = var.fork_source == null || var.fork_source > 0
    error_message = "fork_source must be a positive integer when specified."
  }
}

variable "fork_restore_time" {
  description = "The database timestamp from which it was restored."
  type        = string
  default     = null
}

variable "suspended" {
  description = "Whether this database is suspended."
  type        = bool
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
    condition     = var.private_network == null || (try(var.private_network.subnet_id, 0) > 0 && try(var.private_network.vpc_id, 0) > 0)
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
    condition     = var.updates == null || try(var.updates.day_of_week, null) == null || (try(var.updates.day_of_week, 0) >= 1 && try(var.updates.day_of_week, 0) <= 7)
    error_message = "updates.day_of_week must be between 1 (Monday) and 7 (Sunday)."
  }

  validation {
    condition     = var.updates == null || try(var.updates.hour_of_day, null) == null || (try(var.updates.hour_of_day, -1) >= 0 && try(var.updates.hour_of_day, -1) <= 23)
    error_message = "updates.hour_of_day must be between 0 and 23."
  }

  validation {
    condition     = var.updates == null || try(var.updates.frequency, null) == null || var.updates.frequency == "weekly"
    error_message = "updates.frequency can currently only be weekly."
  }
}

variable "timeouts" {
  description = "The timeouts configuration for the Linode database."
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

# PostgreSQL engine configuration. Each knob maps to a provider
# engine_config_* attribute; leaving it null defers to the platform default.

variable "engine_config_pg_autovacuum_analyze_scale_factor" {
  description = "Specifies a fraction of the table size to add to autovacuum_analyze_threshold when deciding whether to trigger an ANALYZE. The default is 0.2 (20% of table size)"
  type        = number
  default     = null
}

variable "engine_config_pg_autovacuum_analyze_threshold" {
  description = "Specifies the minimum number of inserted, updated or deleted tuples needed to trigger an ANALYZE in any one table. The default is 50 tuples."
  type        = number
  default     = null
}

variable "engine_config_pg_autovacuum_max_workers" {
  description = "Specifies the maximum number of autovacuum processes (other than the autovacuum launcher) that may be running at any one time. The default is three. This parameter can only be set at server start."
  type        = number
  default     = null
}

variable "engine_config_pg_autovacuum_naptime" {
  description = "Specifies the minimum delay between autovacuum runs on any given database. The delay is measured in seconds, and the default is one minute"
  type        = number
  default     = null
}

variable "engine_config_pg_autovacuum_vacuum_cost_delay" {
  description = "Specifies the cost delay value that will be used in automatic VACUUM operations. If -1 is specified, the regular vacuum_cost_delay value will be used. The default value is 20 milliseconds"
  type        = number
  default     = null
}

variable "engine_config_pg_autovacuum_vacuum_cost_limit" {
  description = "Specifies the cost limit value that will be used in automatic VACUUM operations. If -1 is specified (which is the default), the regular vacuum_cost_limit value will be used."
  type        = number
  default     = null
}

variable "engine_config_pg_autovacuum_vacuum_scale_factor" {
  description = "Specifies a fraction of the table size to add to autovacuum_vacuum_threshold when deciding whether to trigger a VACUUM. The default is 0.2 (20% of table size)"
  type        = number
  default     = null
}

variable "engine_config_pg_autovacuum_vacuum_threshold" {
  description = "Specifies the minimum number of updated or deleted tuples needed to trigger a VACUUM in any one table. The default is 50 tuples"
  type        = number
  default     = null
}

variable "engine_config_pg_bgwriter_delay" {
  description = "Specifies the delay between activity rounds for the background writer in milliseconds. Default is 200."
  type        = number
  default     = null
}

variable "engine_config_pg_bgwriter_flush_after" {
  description = "Whenever more than bgwriter_flush_after bytes have been written by the background writer, attempt to force the OS to issue these writes to the underlying storage. Specified in kilobytes, default is 512. Setting of 0 disables forced writeback."
  type        = number
  default     = null
}

variable "engine_config_pg_bgwriter_lru_maxpages" {
  description = "In each round, no more than this many buffers will be written by the background writer. Setting this to zero disables background writing. Default is 100."
  type        = number
  default     = null
}

variable "engine_config_pg_bgwriter_lru_multiplier" {
  description = "The average recent need for new buffers is multiplied by bgwriter_lru_multiplier to arrive at an estimate of the number that will be needed during the next round, (up to bgwriter_lru_maxpages). 1.0 represents a just-in-time policy of writing exactly the number of buffers predicted to be needed. Larger values provide some cushion against spikes in demand, while smaller values intentionally leave writes to be done by server processes. The default is 2.0."
  type        = number
  default     = null
}

variable "engine_config_pg_deadlock_timeout" {
  description = "This is the amount of time, in milliseconds, to wait on a lock before checking to see if there is a deadlock condition."
  type        = number
  default     = null
}

variable "engine_config_pg_default_toast_compression" {
  description = "Specifies the default TOAST compression method for values of compressible columns (the default is lz4)."
  type        = string
  default     = null
}

variable "engine_config_pg_idle_in_transaction_session_timeout" {
  description = "Time out sessions with open transactions after this number of milliseconds"
  type        = number
  default     = null
}

variable "engine_config_pg_jit" {
  description = "Controls system-wide use of Just-in-Time Compilation (JIT)."
  type        = bool
  default     = null
}

variable "engine_config_pg_max_files_per_process" {
  description = "PostgreSQL maximum number of files that can be open per process"
  type        = number
  default     = null
}

variable "engine_config_pg_max_locks_per_transaction" {
  description = "PostgreSQL maximum locks per transaction"
  type        = number
  default     = null
}

variable "engine_config_pg_max_logical_replication_workers" {
  description = "PostgreSQL maximum logical replication workers (taken from the pool of max_parallel_workers)"
  type        = number
  default     = null
}

variable "engine_config_pg_max_parallel_workers" {
  description = "Sets the maximum number of workers that the system can support for parallel queries"
  type        = number
  default     = null
}

variable "engine_config_pg_max_parallel_workers_per_gather" {
  description = "Sets the maximum number of workers that can be started by a single Gather or Gather Merge node"
  type        = number
  default     = null
}

variable "engine_config_pg_max_pred_locks_per_transaction" {
  description = "PostgreSQL maximum predicate locks per transaction"
  type        = number
  default     = null
}

variable "engine_config_pg_max_replication_slots" {
  description = "PostgreSQL maximum replication slots"
  type        = number
  default     = null
}

variable "engine_config_pg_max_slot_wal_keep_size" {
  description = "PostgreSQL maximum WAL size (MB) reserved for replication slots. Default is -1 (unlimited). wal_keep_size minimum WAL size setting takes precedence over this."
  type        = number
  default     = null
}

variable "engine_config_pg_max_stack_depth" {
  description = "Maximum depth of the stack in bytes"
  type        = number
  default     = null
}

variable "engine_config_pg_max_standby_archive_delay" {
  description = "Max standby archive delay in milliseconds"
  type        = number
  default     = null
}

variable "engine_config_pg_max_standby_streaming_delay" {
  description = "Max standby streaming delay in milliseconds"
  type        = number
  default     = null
}

variable "engine_config_pg_max_wal_senders" {
  description = "PostgreSQL maximum WAL senders"
  type        = number
  default     = null
}

variable "engine_config_pg_max_worker_processes" {
  description = "Sets the maximum number of background processes that the system can support"
  type        = number
  default     = null
}

variable "engine_config_pg_password_encryption" {
  description = "Chooses the algorithm for encrypting passwords."
  type        = string
  default     = null
}

variable "engine_config_pg_pg_partman_bgw_interval" {
  description = "Sets the time interval to run pg_partman's scheduled tasks"
  type        = number
  default     = null
}

variable "engine_config_pg_pg_partman_bgw_role" {
  description = "Controls which role to use for pg_partman's scheduled background tasks."
  type        = string
  default     = null
}

variable "engine_config_pg_pg_stat_monitor_pgsm_enable_query_plan" {
  description = "Enables or disables query plan monitoring"
  type        = bool
  default     = null
}

variable "engine_config_pg_pg_stat_monitor_pgsm_max_buckets" {
  description = "Sets the maximum number of buckets"
  type        = number
  default     = null
}

variable "engine_config_pg_pg_stat_statements_track" {
  description = "Controls which statements are counted. Specify top to track top-level statements (those issued directly by clients), all to also track nested statements (such as statements invoked within functions), or none to disable statement statistics collection. The default value is top."
  type        = string
  default     = null

  validation {
    condition     = var.engine_config_pg_pg_stat_statements_track == null || contains(["top", "all", "none"], var.engine_config_pg_pg_stat_statements_track)
    error_message = "engine_config_pg_pg_stat_statements_track must be one of top, all, or none."
  }
}

variable "engine_config_pg_stat_monitor_enable" {
  description = "Enable the pg_stat_monitor extension. Enabling this extension will cause the cluster to be restarted. When this extension is enabled, pg_stat_statements results for utility commands are unreliable."
  type        = bool
  default     = null
}

variable "engine_config_pg_temp_file_limit" {
  description = "PostgreSQL temporary file limit in KiB, -1 for unlimited"
  type        = number
  default     = null
}

variable "engine_config_pg_timezone" {
  description = "PostgreSQL service timezone"
  type        = string
  default     = null
}

variable "engine_config_pg_track_activity_query_size" {
  description = "Specifies the number of bytes reserved to track the currently executing command for each active session."
  type        = number
  default     = null
}

variable "engine_config_pg_track_commit_timestamp" {
  description = "Record commit time of transactions."
  type        = string
  default     = null
}

variable "engine_config_pg_track_functions" {
  description = "Enables tracking of function call counts and time used."
  type        = string
  default     = null
}

variable "engine_config_pg_track_io_timing" {
  description = "Enables timing of database I/O calls. This parameter is off by default, because it will repeatedly query the operating system for the current time, which may cause significant overhead on some platforms."
  type        = string
  default     = null
}

variable "engine_config_pg_wal_sender_timeout" {
  description = "Terminate replication connections that are inactive for longer than this amount of time, in milliseconds. Setting this value to zero disables the timeout."
  type        = number
  default     = null
}

variable "engine_config_pg_wal_writer_delay" {
  description = "WAL flush interval in milliseconds. Note that setting this value to lower than the default 200ms may negatively impact performance."
  type        = number
  default     = null
}

variable "engine_config_pglookout_max_failover_replication_time_lag" {
  description = "Number of seconds of master unavailability before triggering database failover to standby."
  type        = number
  default     = null
}

variable "engine_config_shared_buffers_percentage" {
  description = "Percentage of total RAM that the database server uses for shared memory buffers. Valid range is 20-60 (float), which corresponds to 20% - 60%. This setting adjusts the shared_buffers configuration value."
  type        = number
  default     = null

  validation {
    condition     = var.engine_config_shared_buffers_percentage == null || (var.engine_config_shared_buffers_percentage >= 20 && var.engine_config_shared_buffers_percentage <= 60)
    error_message = "engine_config_shared_buffers_percentage must be between 20 and 60."
  }
}

variable "engine_config_work_mem" {
  description = "Sets the maximum amount of memory to be used by a query operation (such as a sort or hash table) before writing to temporary disk files, in MB. Default is 1MB + 0.075% of total RAM (up to 32MB)."
  type        = number
  default     = null
}
