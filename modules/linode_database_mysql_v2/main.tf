resource "linode_database_mysql_v2" "this" {
  label     = var.label
  engine_id = var.engine_id
  region    = var.region
  type      = var.type

  allow_list        = var.allow_list
  cluster_size      = var.cluster_size
  suspended         = var.suspended
  fork_source       = var.fork_source
  fork_restore_time = var.fork_restore_time

  engine_config_binlog_retention_period                = var.engine_config_binlog_retention_period
  engine_config_mysql_connect_timeout                  = var.engine_config_mysql_connect_timeout
  engine_config_mysql_default_time_zone                = var.engine_config_mysql_default_time_zone
  engine_config_mysql_group_concat_max_len             = var.engine_config_mysql_group_concat_max_len
  engine_config_mysql_information_schema_stats_expiry  = var.engine_config_mysql_information_schema_stats_expiry
  engine_config_mysql_innodb_change_buffer_max_size    = var.engine_config_mysql_innodb_change_buffer_max_size
  engine_config_mysql_innodb_flush_neighbors           = var.engine_config_mysql_innodb_flush_neighbors
  engine_config_mysql_innodb_ft_min_token_size         = var.engine_config_mysql_innodb_ft_min_token_size
  engine_config_mysql_innodb_ft_server_stopword_table  = var.engine_config_mysql_innodb_ft_server_stopword_table
  engine_config_mysql_innodb_lock_wait_timeout         = var.engine_config_mysql_innodb_lock_wait_timeout
  engine_config_mysql_innodb_log_buffer_size           = var.engine_config_mysql_innodb_log_buffer_size
  engine_config_mysql_innodb_online_alter_log_max_size = var.engine_config_mysql_innodb_online_alter_log_max_size
  engine_config_mysql_innodb_read_io_threads           = var.engine_config_mysql_innodb_read_io_threads
  engine_config_mysql_innodb_rollback_on_timeout       = var.engine_config_mysql_innodb_rollback_on_timeout
  engine_config_mysql_innodb_thread_concurrency        = var.engine_config_mysql_innodb_thread_concurrency
  engine_config_mysql_innodb_write_io_threads          = var.engine_config_mysql_innodb_write_io_threads
  engine_config_mysql_interactive_timeout              = var.engine_config_mysql_interactive_timeout
  engine_config_mysql_internal_tmp_mem_storage_engine  = var.engine_config_mysql_internal_tmp_mem_storage_engine
  engine_config_mysql_max_allowed_packet               = var.engine_config_mysql_max_allowed_packet
  engine_config_mysql_max_heap_table_size              = var.engine_config_mysql_max_heap_table_size
  engine_config_mysql_net_buffer_length                = var.engine_config_mysql_net_buffer_length
  engine_config_mysql_net_read_timeout                 = var.engine_config_mysql_net_read_timeout
  engine_config_mysql_net_write_timeout                = var.engine_config_mysql_net_write_timeout
  engine_config_mysql_sort_buffer_size                 = var.engine_config_mysql_sort_buffer_size
  engine_config_mysql_sql_mode                         = var.engine_config_mysql_sql_mode
  engine_config_mysql_sql_require_primary_key          = var.engine_config_mysql_sql_require_primary_key
  engine_config_mysql_tmp_table_size                   = var.engine_config_mysql_tmp_table_size
  engine_config_mysql_wait_timeout                     = var.engine_config_mysql_wait_timeout

  private_network = var.private_network
  updates         = var.updates

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
