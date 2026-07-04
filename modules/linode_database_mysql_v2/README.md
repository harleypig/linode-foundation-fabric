# Linode MySQL Managed Database (v2) Terraform Module

This module creates and manages a single Linode MySQL Managed Database using
the `linode_database_mysql_v2` resource, exposing the engine tuning,
maintenance-window, VPC, and access-list options as validated inputs.

## Usage

```hcl
module "database_mysql_v2" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_database_mysql_v2?ref=v0.2.0"

  label     = "app-mysql-db"
  engine_id = "mysql/8"
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
| [linode_database_mysql_v2.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/database_mysql_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_engine_id"></a> [engine\_id](#input\_engine\_id) | The unique ID of the database engine and version to use. (e.g. mysql/8) | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | A unique, user-defined string referring to the Managed Database. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Region ID for the Managed Database. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The Linode Instance type used by the Managed Database for its nodes. | `string` | n/a | yes |
| <a name="input_allow_list"></a> [allow\_list](#input\_allow\_list) | A list of IP addresses that can access the Managed Database. Each item can be a single IP address or a range in CIDR format. | `set(string)` | `null` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | The number of Linode instance nodes deployed to the Managed Database. | `number` | `null` | no |
| <a name="input_engine_config_binlog_retention_period"></a> [engine\_config\_binlog\_retention\_period](#input\_engine\_config\_binlog\_retention\_period) | The minimum amount of time in seconds to keep binlog entries before deletion. This may be extended for services that require binlog entries for longer than the default for example if using the MySQL Debezium Kafka connector. | `number` | `null` | no |
| <a name="input_engine_config_mysql_connect_timeout"></a> [engine\_config\_mysql\_connect\_timeout](#input\_engine\_config\_mysql\_connect\_timeout) | The number of seconds that the mysqld server waits for a connect packet before responding with Bad handshake. | `number` | `null` | no |
| <a name="input_engine_config_mysql_default_time_zone"></a> [engine\_config\_mysql\_default\_time\_zone](#input\_engine\_config\_mysql\_default\_time\_zone) | Default server time zone as an offset from UTC (from -12:00 to +12:00), a time zone name, or 'SYSTEM' to use the MySQL server default. | `string` | `null` | no |
| <a name="input_engine_config_mysql_group_concat_max_len"></a> [engine\_config\_mysql\_group\_concat\_max\_len](#input\_engine\_config\_mysql\_group\_concat\_max\_len) | The maximum permitted result length in bytes for the GROUP\_CONCAT() function. | `number` | `null` | no |
| <a name="input_engine_config_mysql_information_schema_stats_expiry"></a> [engine\_config\_mysql\_information\_schema\_stats\_expiry](#input\_engine\_config\_mysql\_information\_schema\_stats\_expiry) | The time, in seconds, before cached statistics expire. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_change_buffer_max_size"></a> [engine\_config\_mysql\_innodb\_change\_buffer\_max\_size](#input\_engine\_config\_mysql\_innodb\_change\_buffer\_max\_size) | Maximum size for the InnoDB change buffer, as a percentage of the total size of the buffer pool. Default is 25. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_flush_neighbors"></a> [engine\_config\_mysql\_innodb\_flush\_neighbors](#input\_engine\_config\_mysql\_innodb\_flush\_neighbors) | Specifies whether flushing a page from the InnoDB buffer pool also flushes other dirty pages in the same extent (default is 1): 0 - dirty pages in the same extent are not flushed, 1 - flush contiguous dirty pages in the same extent, 2 - flush dirty pages in the same extent. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_ft_min_token_size"></a> [engine\_config\_mysql\_innodb\_ft\_min\_token\_size](#input\_engine\_config\_mysql\_innodb\_ft\_min\_token\_size) | Minimum length of words that are stored in an InnoDB FULLTEXT index. Changing this parameter will lead to a restart of the MySQL service. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_ft_server_stopword_table"></a> [engine\_config\_mysql\_innodb\_ft\_server\_stopword\_table](#input\_engine\_config\_mysql\_innodb\_ft\_server\_stopword\_table) | This option is used to specify your own InnoDB FULLTEXT index stopword list for all InnoDB tables. | `string` | `null` | no |
| <a name="input_engine_config_mysql_innodb_lock_wait_timeout"></a> [engine\_config\_mysql\_innodb\_lock\_wait\_timeout](#input\_engine\_config\_mysql\_innodb\_lock\_wait\_timeout) | The length of time in seconds an InnoDB transaction waits for a row lock before giving up. Default is 120. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_log_buffer_size"></a> [engine\_config\_mysql\_innodb\_log\_buffer\_size](#input\_engine\_config\_mysql\_innodb\_log\_buffer\_size) | The size in bytes of the buffer that InnoDB uses to write to the log files on disk. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_online_alter_log_max_size"></a> [engine\_config\_mysql\_innodb\_online\_alter\_log\_max\_size](#input\_engine\_config\_mysql\_innodb\_online\_alter\_log\_max\_size) | The upper limit in bytes on the size of the temporary log files used during online DDL operations for InnoDB tables. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_read_io_threads"></a> [engine\_config\_mysql\_innodb\_read\_io\_threads](#input\_engine\_config\_mysql\_innodb\_read\_io\_threads) | The number of I/O threads for read operations in InnoDB. Default is 4. Changing this parameter will lead to a restart of the MySQL service. | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_rollback_on_timeout"></a> [engine\_config\_mysql\_innodb\_rollback\_on\_timeout](#input\_engine\_config\_mysql\_innodb\_rollback\_on\_timeout) | When enabled a transaction timeout causes InnoDB to abort and roll back the entire transaction. Changing this parameter will lead to a restart of the MySQL service. | `bool` | `null` | no |
| <a name="input_engine_config_mysql_innodb_thread_concurrency"></a> [engine\_config\_mysql\_innodb\_thread\_concurrency](#input\_engine\_config\_mysql\_innodb\_thread\_concurrency) | Defines the maximum number of threads permitted inside of InnoDB. Default is 0 (infinite concurrency - no limit). | `number` | `null` | no |
| <a name="input_engine_config_mysql_innodb_write_io_threads"></a> [engine\_config\_mysql\_innodb\_write\_io\_threads](#input\_engine\_config\_mysql\_innodb\_write\_io\_threads) | The number of I/O threads for write operations in InnoDB. Default is 4. Changing this parameter will lead to a restart of the MySQL service. | `number` | `null` | no |
| <a name="input_engine_config_mysql_interactive_timeout"></a> [engine\_config\_mysql\_interactive\_timeout](#input\_engine\_config\_mysql\_interactive\_timeout) | The number of seconds the server waits for activity on an interactive connection before closing it. | `number` | `null` | no |
| <a name="input_engine_config_mysql_internal_tmp_mem_storage_engine"></a> [engine\_config\_mysql\_internal\_tmp\_mem\_storage\_engine](#input\_engine\_config\_mysql\_internal\_tmp\_mem\_storage\_engine) | The storage engine for in-memory internal temporary tables. | `string` | `null` | no |
| <a name="input_engine_config_mysql_max_allowed_packet"></a> [engine\_config\_mysql\_max\_allowed\_packet](#input\_engine\_config\_mysql\_max\_allowed\_packet) | Size of the largest message in bytes that can be received by the server. Default is 67108864 (64M). | `number` | `null` | no |
| <a name="input_engine_config_mysql_max_heap_table_size"></a> [engine\_config\_mysql\_max\_heap\_table\_size](#input\_engine\_config\_mysql\_max\_heap\_table\_size) | Limits the size of internal in-memory tables. Also set tmp\_table\_size. Default is 16777216 (16M). | `number` | `null` | no |
| <a name="input_engine_config_mysql_net_buffer_length"></a> [engine\_config\_mysql\_net\_buffer\_length](#input\_engine\_config\_mysql\_net\_buffer\_length) | Start sizes of connection buffer and result buffer. Default is 16384 (16K). Changing this parameter will lead to a restart of the MySQL service. | `number` | `null` | no |
| <a name="input_engine_config_mysql_net_read_timeout"></a> [engine\_config\_mysql\_net\_read\_timeout](#input\_engine\_config\_mysql\_net\_read\_timeout) | The number of seconds to wait for more data from a connection before aborting the read. | `number` | `null` | no |
| <a name="input_engine_config_mysql_net_write_timeout"></a> [engine\_config\_mysql\_net\_write\_timeout](#input\_engine\_config\_mysql\_net\_write\_timeout) | The number of seconds to wait for a block to be written to a connection before aborting the write. | `number` | `null` | no |
| <a name="input_engine_config_mysql_sort_buffer_size"></a> [engine\_config\_mysql\_sort\_buffer\_size](#input\_engine\_config\_mysql\_sort\_buffer\_size) | Sort buffer size in bytes for ORDER BY optimization. Default is 262144 (256K). | `number` | `null` | no |
| <a name="input_engine_config_mysql_sql_mode"></a> [engine\_config\_mysql\_sql\_mode](#input\_engine\_config\_mysql\_sql\_mode) | Global SQL mode. Set to empty to use MySQL server defaults. When creating a new service and not setting this field Aiven default SQL mode (strict, SQL standard compliant) will be assigned. | `string` | `null` | no |
| <a name="input_engine_config_mysql_sql_require_primary_key"></a> [engine\_config\_mysql\_sql\_require\_primary\_key](#input\_engine\_config\_mysql\_sql\_require\_primary\_key) | Require primary key to be defined for new tables or old tables modified with ALTER TABLE and fail if missing. It is recommended to always have primary keys because various functionality may break if any large table is missing them. | `bool` | `null` | no |
| <a name="input_engine_config_mysql_tmp_table_size"></a> [engine\_config\_mysql\_tmp\_table\_size](#input\_engine\_config\_mysql\_tmp\_table\_size) | Limits the size of internal in-memory tables. Also set max\_heap\_table\_size. Default is 16777216 (16M). | `number` | `null` | no |
| <a name="input_engine_config_mysql_wait_timeout"></a> [engine\_config\_mysql\_wait\_timeout](#input\_engine\_config\_mysql\_wait\_timeout) | The number of seconds the server waits for activity on a noninteractive connection before closing it. | `number` | `null` | no |
| <a name="input_fork_restore_time"></a> [fork\_restore\_time](#input\_fork\_restore\_time) | The database timestamp from which it was restored. | `string` | `null` | no |
| <a name="input_fork_source"></a> [fork\_source](#input\_fork\_source) | The ID of the database that was forked from. | `number` | `null` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | Restricts access to this database using a virtual private cloud (VPC) that you've configured in the region where the database will live. | <pre>object({<br/>    public_access = optional(bool)<br/>    subnet_id     = number<br/>    vpc_id        = number<br/>  })</pre> | `null` | no |
| <a name="input_suspended"></a> [suspended](#input\_suspended) | Whether this database is suspended. | `bool` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | The timeouts configuration for the Linode Managed Database. | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
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
| <a name="output_id"></a> [id](#output\_id) | The id of the MySQL Database. |
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

- `root_username`, `root_password`, and `ca_cert` are generated by Linode and
  exposed as **sensitive** outputs; treat them as secrets.
- Most `engine_config_*` inputs are `optional + computed`: leave them `null`
  to accept the Linode/Aiven server default rather than pinning a value.
- `private_network` and `updates` are nested attributes (not blocks) — pass
  them as objects. Restricting access via `private_network` requires a VPC and
  subnet already configured in the database's region.
- `cluster_size` of 1 is a single node (no high availability); use 3 for a
  high-availability cluster.
