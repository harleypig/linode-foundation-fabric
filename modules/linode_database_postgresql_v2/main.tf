resource "linode_database_postgresql_v2" "this" {
  engine_id = var.engine_id
  label     = var.label
  region    = var.region
  type      = var.type

  allow_list        = var.allow_list
  cluster_size      = var.cluster_size
  fork_source       = var.fork_source
  fork_restore_time = var.fork_restore_time
  suspended         = var.suspended

  private_network = var.private_network
  updates         = var.updates

  engine_config_pg_autovacuum_analyze_scale_factor          = var.engine_config_pg_autovacuum_analyze_scale_factor
  engine_config_pg_autovacuum_analyze_threshold             = var.engine_config_pg_autovacuum_analyze_threshold
  engine_config_pg_autovacuum_max_workers                   = var.engine_config_pg_autovacuum_max_workers
  engine_config_pg_autovacuum_naptime                       = var.engine_config_pg_autovacuum_naptime
  engine_config_pg_autovacuum_vacuum_cost_delay             = var.engine_config_pg_autovacuum_vacuum_cost_delay
  engine_config_pg_autovacuum_vacuum_cost_limit             = var.engine_config_pg_autovacuum_vacuum_cost_limit
  engine_config_pg_autovacuum_vacuum_scale_factor           = var.engine_config_pg_autovacuum_vacuum_scale_factor
  engine_config_pg_autovacuum_vacuum_threshold              = var.engine_config_pg_autovacuum_vacuum_threshold
  engine_config_pg_bgwriter_delay                           = var.engine_config_pg_bgwriter_delay
  engine_config_pg_bgwriter_flush_after                     = var.engine_config_pg_bgwriter_flush_after
  engine_config_pg_bgwriter_lru_maxpages                    = var.engine_config_pg_bgwriter_lru_maxpages
  engine_config_pg_bgwriter_lru_multiplier                  = var.engine_config_pg_bgwriter_lru_multiplier
  engine_config_pg_deadlock_timeout                         = var.engine_config_pg_deadlock_timeout
  engine_config_pg_default_toast_compression                = var.engine_config_pg_default_toast_compression
  engine_config_pg_idle_in_transaction_session_timeout      = var.engine_config_pg_idle_in_transaction_session_timeout
  engine_config_pg_jit                                      = var.engine_config_pg_jit
  engine_config_pg_max_files_per_process                    = var.engine_config_pg_max_files_per_process
  engine_config_pg_max_locks_per_transaction                = var.engine_config_pg_max_locks_per_transaction
  engine_config_pg_max_logical_replication_workers          = var.engine_config_pg_max_logical_replication_workers
  engine_config_pg_max_parallel_workers                     = var.engine_config_pg_max_parallel_workers
  engine_config_pg_max_parallel_workers_per_gather          = var.engine_config_pg_max_parallel_workers_per_gather
  engine_config_pg_max_pred_locks_per_transaction           = var.engine_config_pg_max_pred_locks_per_transaction
  engine_config_pg_max_replication_slots                    = var.engine_config_pg_max_replication_slots
  engine_config_pg_max_slot_wal_keep_size                   = var.engine_config_pg_max_slot_wal_keep_size
  engine_config_pg_max_stack_depth                          = var.engine_config_pg_max_stack_depth
  engine_config_pg_max_standby_archive_delay                = var.engine_config_pg_max_standby_archive_delay
  engine_config_pg_max_standby_streaming_delay              = var.engine_config_pg_max_standby_streaming_delay
  engine_config_pg_max_wal_senders                          = var.engine_config_pg_max_wal_senders
  engine_config_pg_max_worker_processes                     = var.engine_config_pg_max_worker_processes
  engine_config_pg_password_encryption                      = var.engine_config_pg_password_encryption
  engine_config_pg_pg_partman_bgw_interval                  = var.engine_config_pg_pg_partman_bgw_interval
  engine_config_pg_pg_partman_bgw_role                      = var.engine_config_pg_pg_partman_bgw_role
  engine_config_pg_pg_stat_monitor_pgsm_enable_query_plan   = var.engine_config_pg_pg_stat_monitor_pgsm_enable_query_plan
  engine_config_pg_pg_stat_monitor_pgsm_max_buckets         = var.engine_config_pg_pg_stat_monitor_pgsm_max_buckets
  engine_config_pg_pg_stat_statements_track                 = var.engine_config_pg_pg_stat_statements_track
  engine_config_pg_stat_monitor_enable                      = var.engine_config_pg_stat_monitor_enable
  engine_config_pg_temp_file_limit                          = var.engine_config_pg_temp_file_limit
  engine_config_pg_timezone                                 = var.engine_config_pg_timezone
  engine_config_pg_track_activity_query_size                = var.engine_config_pg_track_activity_query_size
  engine_config_pg_track_commit_timestamp                   = var.engine_config_pg_track_commit_timestamp
  engine_config_pg_track_functions                          = var.engine_config_pg_track_functions
  engine_config_pg_track_io_timing                          = var.engine_config_pg_track_io_timing
  engine_config_pg_wal_sender_timeout                       = var.engine_config_pg_wal_sender_timeout
  engine_config_pg_wal_writer_delay                         = var.engine_config_pg_wal_writer_delay
  engine_config_pglookout_max_failover_replication_time_lag = var.engine_config_pglookout_max_failover_replication_time_lag
  engine_config_shared_buffers_percentage                   = var.engine_config_shared_buffers_percentage
  engine_config_work_mem                                    = var.engine_config_work_mem

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
