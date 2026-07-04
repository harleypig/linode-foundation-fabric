# Linode PostgreSQL Managed Database (v2) Terraform Module

This module creates and manages a single Linode Managed PostgreSQL Database
(`linode_database_postgresql_v2`), including its allow list, cluster sizing,
maintenance window, optional VPC private networking, and the full set of
PostgreSQL engine tuning parameters.

## Usage

```hcl
module "database_postgresql_v2" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_database_postgresql_v2?ref=v0.2.0"

  engine_id = "postgresql/16"
  label     = "app-primary-db"
  region    = "us-east"
  type      = "g6-nanode-1"
}
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_database_postgresql_v2.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/database_postgresql_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_engine_id"></a> [engine\_id](#input\_engine\_id) | The unique ID of the database engine and version to use. (e.g. postgresql/16) | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | A unique, user-defined string referring to the Managed Database. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Region ID for the Managed Database. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The Linode Instance type used by the Managed Database for its nodes. | `string` | n/a | yes |
| <a name="input_allow_list"></a> [allow\_list](#input\_allow\_list) | A list of IP addresses that can access the Managed Database. Each item can be a single IP address or a range in CIDR format. | `set(string)` | `null` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | The number of Linode instance nodes deployed to the Managed Database. | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_analyze_scale_factor"></a> [engine\_config\_pg\_autovacuum\_analyze\_scale\_factor](#input\_engine\_config\_pg\_autovacuum\_analyze\_scale\_factor) | Specifies a fraction of the table size to add to autovacuum\_analyze\_threshold when deciding whether to trigger an ANALYZE. The default is 0.2 (20% of table size) | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_analyze_threshold"></a> [engine\_config\_pg\_autovacuum\_analyze\_threshold](#input\_engine\_config\_pg\_autovacuum\_analyze\_threshold) | Specifies the minimum number of inserted, updated or deleted tuples needed to trigger an ANALYZE in any one table. The default is 50 tuples. | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_max_workers"></a> [engine\_config\_pg\_autovacuum\_max\_workers](#input\_engine\_config\_pg\_autovacuum\_max\_workers) | Specifies the maximum number of autovacuum processes (other than the autovacuum launcher) that may be running at any one time. The default is three. This parameter can only be set at server start. | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_naptime"></a> [engine\_config\_pg\_autovacuum\_naptime](#input\_engine\_config\_pg\_autovacuum\_naptime) | Specifies the minimum delay between autovacuum runs on any given database. The delay is measured in seconds, and the default is one minute | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_vacuum_cost_delay"></a> [engine\_config\_pg\_autovacuum\_vacuum\_cost\_delay](#input\_engine\_config\_pg\_autovacuum\_vacuum\_cost\_delay) | Specifies the cost delay value that will be used in automatic VACUUM operations. If -1 is specified, the regular vacuum\_cost\_delay value will be used. The default value is 20 milliseconds | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_vacuum_cost_limit"></a> [engine\_config\_pg\_autovacuum\_vacuum\_cost\_limit](#input\_engine\_config\_pg\_autovacuum\_vacuum\_cost\_limit) | Specifies the cost limit value that will be used in automatic VACUUM operations. If -1 is specified (which is the default), the regular vacuum\_cost\_limit value will be used. | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_vacuum_scale_factor"></a> [engine\_config\_pg\_autovacuum\_vacuum\_scale\_factor](#input\_engine\_config\_pg\_autovacuum\_vacuum\_scale\_factor) | Specifies a fraction of the table size to add to autovacuum\_vacuum\_threshold when deciding whether to trigger a VACUUM. The default is 0.2 (20% of table size) | `number` | `null` | no |
| <a name="input_engine_config_pg_autovacuum_vacuum_threshold"></a> [engine\_config\_pg\_autovacuum\_vacuum\_threshold](#input\_engine\_config\_pg\_autovacuum\_vacuum\_threshold) | Specifies the minimum number of updated or deleted tuples needed to trigger a VACUUM in any one table. The default is 50 tuples | `number` | `null` | no |
| <a name="input_engine_config_pg_bgwriter_delay"></a> [engine\_config\_pg\_bgwriter\_delay](#input\_engine\_config\_pg\_bgwriter\_delay) | Specifies the delay between activity rounds for the background writer in milliseconds. Default is 200. | `number` | `null` | no |
| <a name="input_engine_config_pg_bgwriter_flush_after"></a> [engine\_config\_pg\_bgwriter\_flush\_after](#input\_engine\_config\_pg\_bgwriter\_flush\_after) | Whenever more than bgwriter\_flush\_after bytes have been written by the background writer, attempt to force the OS to issue these writes to the underlying storage. Specified in kilobytes, default is 512. Setting of 0 disables forced writeback. | `number` | `null` | no |
| <a name="input_engine_config_pg_bgwriter_lru_maxpages"></a> [engine\_config\_pg\_bgwriter\_lru\_maxpages](#input\_engine\_config\_pg\_bgwriter\_lru\_maxpages) | In each round, no more than this many buffers will be written by the background writer. Setting this to zero disables background writing. Default is 100. | `number` | `null` | no |
| <a name="input_engine_config_pg_bgwriter_lru_multiplier"></a> [engine\_config\_pg\_bgwriter\_lru\_multiplier](#input\_engine\_config\_pg\_bgwriter\_lru\_multiplier) | The average recent need for new buffers is multiplied by bgwriter\_lru\_multiplier to arrive at an estimate of the number that will be needed during the next round, (up to bgwriter\_lru\_maxpages). 1.0 represents a just-in-time policy of writing exactly the number of buffers predicted to be needed. Larger values provide some cushion against spikes in demand, while smaller values intentionally leave writes to be done by server processes. The default is 2.0. | `number` | `null` | no |
| <a name="input_engine_config_pg_deadlock_timeout"></a> [engine\_config\_pg\_deadlock\_timeout](#input\_engine\_config\_pg\_deadlock\_timeout) | This is the amount of time, in milliseconds, to wait on a lock before checking to see if there is a deadlock condition. | `number` | `null` | no |
| <a name="input_engine_config_pg_default_toast_compression"></a> [engine\_config\_pg\_default\_toast\_compression](#input\_engine\_config\_pg\_default\_toast\_compression) | Specifies the default TOAST compression method for values of compressible columns (the default is lz4). | `string` | `null` | no |
| <a name="input_engine_config_pg_idle_in_transaction_session_timeout"></a> [engine\_config\_pg\_idle\_in\_transaction\_session\_timeout](#input\_engine\_config\_pg\_idle\_in\_transaction\_session\_timeout) | Time out sessions with open transactions after this number of milliseconds | `number` | `null` | no |
| <a name="input_engine_config_pg_jit"></a> [engine\_config\_pg\_jit](#input\_engine\_config\_pg\_jit) | Controls system-wide use of Just-in-Time Compilation (JIT). | `bool` | `null` | no |
| <a name="input_engine_config_pg_max_files_per_process"></a> [engine\_config\_pg\_max\_files\_per\_process](#input\_engine\_config\_pg\_max\_files\_per\_process) | PostgreSQL maximum number of files that can be open per process | `number` | `null` | no |
| <a name="input_engine_config_pg_max_locks_per_transaction"></a> [engine\_config\_pg\_max\_locks\_per\_transaction](#input\_engine\_config\_pg\_max\_locks\_per\_transaction) | PostgreSQL maximum locks per transaction | `number` | `null` | no |
| <a name="input_engine_config_pg_max_logical_replication_workers"></a> [engine\_config\_pg\_max\_logical\_replication\_workers](#input\_engine\_config\_pg\_max\_logical\_replication\_workers) | PostgreSQL maximum logical replication workers (taken from the pool of max\_parallel\_workers) | `number` | `null` | no |
| <a name="input_engine_config_pg_max_parallel_workers"></a> [engine\_config\_pg\_max\_parallel\_workers](#input\_engine\_config\_pg\_max\_parallel\_workers) | Sets the maximum number of workers that the system can support for parallel queries | `number` | `null` | no |
| <a name="input_engine_config_pg_max_parallel_workers_per_gather"></a> [engine\_config\_pg\_max\_parallel\_workers\_per\_gather](#input\_engine\_config\_pg\_max\_parallel\_workers\_per\_gather) | Sets the maximum number of workers that can be started by a single Gather or Gather Merge node | `number` | `null` | no |
| <a name="input_engine_config_pg_max_pred_locks_per_transaction"></a> [engine\_config\_pg\_max\_pred\_locks\_per\_transaction](#input\_engine\_config\_pg\_max\_pred\_locks\_per\_transaction) | PostgreSQL maximum predicate locks per transaction | `number` | `null` | no |
| <a name="input_engine_config_pg_max_replication_slots"></a> [engine\_config\_pg\_max\_replication\_slots](#input\_engine\_config\_pg\_max\_replication\_slots) | PostgreSQL maximum replication slots | `number` | `null` | no |
| <a name="input_engine_config_pg_max_slot_wal_keep_size"></a> [engine\_config\_pg\_max\_slot\_wal\_keep\_size](#input\_engine\_config\_pg\_max\_slot\_wal\_keep\_size) | PostgreSQL maximum WAL size (MB) reserved for replication slots. Default is -1 (unlimited). wal\_keep\_size minimum WAL size setting takes precedence over this. | `number` | `null` | no |
| <a name="input_engine_config_pg_max_stack_depth"></a> [engine\_config\_pg\_max\_stack\_depth](#input\_engine\_config\_pg\_max\_stack\_depth) | Maximum depth of the stack in bytes | `number` | `null` | no |
| <a name="input_engine_config_pg_max_standby_archive_delay"></a> [engine\_config\_pg\_max\_standby\_archive\_delay](#input\_engine\_config\_pg\_max\_standby\_archive\_delay) | Max standby archive delay in milliseconds | `number` | `null` | no |
| <a name="input_engine_config_pg_max_standby_streaming_delay"></a> [engine\_config\_pg\_max\_standby\_streaming\_delay](#input\_engine\_config\_pg\_max\_standby\_streaming\_delay) | Max standby streaming delay in milliseconds | `number` | `null` | no |
| <a name="input_engine_config_pg_max_wal_senders"></a> [engine\_config\_pg\_max\_wal\_senders](#input\_engine\_config\_pg\_max\_wal\_senders) | PostgreSQL maximum WAL senders | `number` | `null` | no |
| <a name="input_engine_config_pg_max_worker_processes"></a> [engine\_config\_pg\_max\_worker\_processes](#input\_engine\_config\_pg\_max\_worker\_processes) | Sets the maximum number of background processes that the system can support | `number` | `null` | no |
| <a name="input_engine_config_pg_password_encryption"></a> [engine\_config\_pg\_password\_encryption](#input\_engine\_config\_pg\_password\_encryption) | Chooses the algorithm for encrypting passwords. | `string` | `null` | no |
| <a name="input_engine_config_pg_pg_partman_bgw_interval"></a> [engine\_config\_pg\_pg\_partman\_bgw\_interval](#input\_engine\_config\_pg\_pg\_partman\_bgw\_interval) | Sets the time interval to run pg\_partman's scheduled tasks | `number` | `null` | no |
| <a name="input_engine_config_pg_pg_partman_bgw_role"></a> [engine\_config\_pg\_pg\_partman\_bgw\_role](#input\_engine\_config\_pg\_pg\_partman\_bgw\_role) | Controls which role to use for pg\_partman's scheduled background tasks. | `string` | `null` | no |
| <a name="input_engine_config_pg_pg_stat_monitor_pgsm_enable_query_plan"></a> [engine\_config\_pg\_pg\_stat\_monitor\_pgsm\_enable\_query\_plan](#input\_engine\_config\_pg\_pg\_stat\_monitor\_pgsm\_enable\_query\_plan) | Enables or disables query plan monitoring | `bool` | `null` | no |
| <a name="input_engine_config_pg_pg_stat_monitor_pgsm_max_buckets"></a> [engine\_config\_pg\_pg\_stat\_monitor\_pgsm\_max\_buckets](#input\_engine\_config\_pg\_pg\_stat\_monitor\_pgsm\_max\_buckets) | Sets the maximum number of buckets | `number` | `null` | no |
| <a name="input_engine_config_pg_pg_stat_statements_track"></a> [engine\_config\_pg\_pg\_stat\_statements\_track](#input\_engine\_config\_pg\_pg\_stat\_statements\_track) | Controls which statements are counted. Specify top to track top-level statements (those issued directly by clients), all to also track nested statements (such as statements invoked within functions), or none to disable statement statistics collection. The default value is top. | `string` | `null` | no |
| <a name="input_engine_config_pg_stat_monitor_enable"></a> [engine\_config\_pg\_stat\_monitor\_enable](#input\_engine\_config\_pg\_stat\_monitor\_enable) | Enable the pg\_stat\_monitor extension. Enabling this extension will cause the cluster to be restarted. When this extension is enabled, pg\_stat\_statements results for utility commands are unreliable. | `bool` | `null` | no |
| <a name="input_engine_config_pg_temp_file_limit"></a> [engine\_config\_pg\_temp\_file\_limit](#input\_engine\_config\_pg\_temp\_file\_limit) | PostgreSQL temporary file limit in KiB, -1 for unlimited | `number` | `null` | no |
| <a name="input_engine_config_pg_timezone"></a> [engine\_config\_pg\_timezone](#input\_engine\_config\_pg\_timezone) | PostgreSQL service timezone | `string` | `null` | no |
| <a name="input_engine_config_pg_track_activity_query_size"></a> [engine\_config\_pg\_track\_activity\_query\_size](#input\_engine\_config\_pg\_track\_activity\_query\_size) | Specifies the number of bytes reserved to track the currently executing command for each active session. | `number` | `null` | no |
| <a name="input_engine_config_pg_track_commit_timestamp"></a> [engine\_config\_pg\_track\_commit\_timestamp](#input\_engine\_config\_pg\_track\_commit\_timestamp) | Record commit time of transactions. | `string` | `null` | no |
| <a name="input_engine_config_pg_track_functions"></a> [engine\_config\_pg\_track\_functions](#input\_engine\_config\_pg\_track\_functions) | Enables tracking of function call counts and time used. | `string` | `null` | no |
| <a name="input_engine_config_pg_track_io_timing"></a> [engine\_config\_pg\_track\_io\_timing](#input\_engine\_config\_pg\_track\_io\_timing) | Enables timing of database I/O calls. This parameter is off by default, because it will repeatedly query the operating system for the current time, which may cause significant overhead on some platforms. | `string` | `null` | no |
| <a name="input_engine_config_pg_wal_sender_timeout"></a> [engine\_config\_pg\_wal\_sender\_timeout](#input\_engine\_config\_pg\_wal\_sender\_timeout) | Terminate replication connections that are inactive for longer than this amount of time, in milliseconds. Setting this value to zero disables the timeout. | `number` | `null` | no |
| <a name="input_engine_config_pg_wal_writer_delay"></a> [engine\_config\_pg\_wal\_writer\_delay](#input\_engine\_config\_pg\_wal\_writer\_delay) | WAL flush interval in milliseconds. Note that setting this value to lower than the default 200ms may negatively impact performance. | `number` | `null` | no |
| <a name="input_engine_config_pglookout_max_failover_replication_time_lag"></a> [engine\_config\_pglookout\_max\_failover\_replication\_time\_lag](#input\_engine\_config\_pglookout\_max\_failover\_replication\_time\_lag) | Number of seconds of master unavailability before triggering database failover to standby. | `number` | `null` | no |
| <a name="input_engine_config_shared_buffers_percentage"></a> [engine\_config\_shared\_buffers\_percentage](#input\_engine\_config\_shared\_buffers\_percentage) | Percentage of total RAM that the database server uses for shared memory buffers. Valid range is 20-60 (float), which corresponds to 20% - 60%. This setting adjusts the shared\_buffers configuration value. | `number` | `null` | no |
| <a name="input_engine_config_work_mem"></a> [engine\_config\_work\_mem](#input\_engine\_config\_work\_mem) | Sets the maximum amount of memory to be used by a query operation (such as a sort or hash table) before writing to temporary disk files, in MB. Default is 1MB + 0.075% of total RAM (up to 32MB). | `number` | `null` | no |
| <a name="input_fork_restore_time"></a> [fork\_restore\_time](#input\_fork\_restore\_time) | The database timestamp from which it was restored. | `string` | `null` | no |
| <a name="input_fork_source"></a> [fork\_source](#input\_fork\_source) | The ID of the database that was forked from. | `number` | `null` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | Restricts access to this database using a virtual private cloud (VPC) that you've configured in the region where the database will live. | <pre>object({<br/>    public_access = optional(bool)<br/>    subnet_id     = number<br/>    vpc_id        = number<br/>  })</pre> | `null` | no |
| <a name="input_suspended"></a> [suspended](#input\_suspended) | Whether this database is suspended. | `bool` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | The timeouts configuration for the Linode database. | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_updates"></a> [updates](#input\_updates) | Configuration settings for automated patch update maintenance for the Managed Database. | <pre>object({<br/>    day_of_week = optional(number)<br/>    duration    = optional(number)<br/>    frequency   = optional(string)<br/>    hour_of_day = optional(number)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_cert"></a> [ca\_cert](#output\_ca\_cert) | The base64-encoded SSL CA certificate for the Managed Database. |
| <a name="output_created"></a> [created](#output\_created) | When this Managed Database was created. |
| <a name="output_encrypted"></a> [encrypted](#output\_encrypted) | Whether the Managed Database is encrypted. |
| <a name="output_engine"></a> [engine](#output\_engine) | The Managed Database engine in engine/version format. |
| <a name="output_host_primary"></a> [host\_primary](#output\_host\_primary) | The primary host for the Managed Database. |
| <a name="output_host_standby"></a> [host\_standby](#output\_host\_standby) | The standby host for the Managed Database. |
| <a name="output_id"></a> [id](#output\_id) | The id of the PostgreSQL Database. |
| <a name="output_members"></a> [members](#output\_members) | A mapping between IP addresses and strings designating them as primary or failover. |
| <a name="output_oldest_restore_time"></a> [oldest\_restore\_time](#output\_oldest\_restore\_time) | The oldest time to which a database can be restored. |
| <a name="output_pending_updates"></a> [pending\_updates](#output\_pending\_updates) | A set of pending updates. |
| <a name="output_platform"></a> [platform](#output\_platform) | The back-end platform for relational databases used by the service. |
| <a name="output_port"></a> [port](#output\_port) | The access port for this Managed Database. |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | The randomly generated root password for the Managed Database instance. |
| <a name="output_root_username"></a> [root\_username](#output\_root\_username) | The root username for the Managed Database instance. |
| <a name="output_ssl_connection"></a> [ssl\_connection](#output\_ssl\_connection) | Whether to require SSL credentials to establish a connection to the Managed Database. |
| <a name="output_status"></a> [status](#output\_status) | The operating status of the Managed Database. |
| <a name="output_updated"></a> [updated](#output\_updated) | When this Managed Database was last updated. |
| <a name="output_version"></a> [version](#output\_version) | The Managed Database engine version. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `type` and `region` are set at creation; changing them forces the provider
  to plan a replacement of the database.
- Connection details (`host_primary`, `host_standby`, `port`) and the
  credentials (`root_username`, `root_password`, `ca_cert`) are computed and
  only known after apply; the credential outputs are marked sensitive.
- `allow_list` and `updates` are `optional`/`computed` — leaving them unset
  lets the platform manage them, so an empty diff after apply is expected
  rather than drift.
- The `engine_config_*` inputs default to `null`, which defers to the
  platform's default for that parameter; only set the ones you need to tune.
- `allow_list` validation accepts IPv4/IPv6 addresses and CIDR ranges; the
  regex is intentionally permissive and does not fully validate every IPv6
  form.
