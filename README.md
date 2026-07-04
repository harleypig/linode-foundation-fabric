# linode-foundation-fabric

Reusable, single-resource Terraform modules for [Linode][ln] — a "foundation
fabric" (Cloud Foundation Fabric-style) library built on the published
[`linode/linode`][prov] provider. Each module wraps one Linode resource with
validated inputs, a factory `for_each` interface, and plan-only tests.

Extracted from [harleydev][hd]'s `tfmods/` (history preserved). This repo is
**generic and reusable**; it holds no account-specific configuration. It is
consumed by git ref from a root configuration (for example, harleydev, which
manages the live account).

## Modules

Each module under `modules/` wraps the Linode resource of the same name:

| Module | Wraps |
|--------|-------|
| `linode_account_settings` | `linode_account_settings` |
| `linode_database_access_controls` | `linode_database_access_controls` |
| `linode_database_mysql_v2` | `linode_database_mysql_v2` |
| `linode_database_postgresql_v2` | `linode_database_postgresql_v2` |
| `linode_domain` | `linode_domain` |
| `linode_domain_record` | `linode_domain_record` |
| `linode_firewall` | `linode_firewall` |
| `linode_firewall_device` | `linode_firewall_device` |
| `linode_firewall_settings` | `linode_firewall_settings` |
| `linode_iam_user` | `linode_iam_user` |
| `linode_image` | `linode_image` |
| `linode_instance` | `linode_instance` |
| `linode_instance_config` | `linode_instance_config` |
| `linode_instance_disk` | `linode_instance_disk` |
| `linode_instance_ip` | `linode_instance_ip` |
| `linode_instance_shared_ips` | `linode_instance_shared_ips` |
| `linode_interface` | `linode_interface` |
| `linode_ipv6_range` | `linode_ipv6_range` |
| `linode_lke_cluster` | `linode_lke_cluster` |
| `linode_lke_node_pool` | `linode_lke_node_pool` |
| `linode_monitor_alert_definition` | `linode_monitor_alert_definition` |
| `linode_networking_ip` | `linode_networking_ip` |
| `linode_networking_ip_assignment` | `linode_networking_ip_assignment` |
| `linode_nodebalancer` | `linode_nodebalancer` |
| `linode_nodebalancer_config` | `linode_nodebalancer_config` |
| `linode_nodebalancer_node` | `linode_nodebalancer_node` |
| `linode_object_storage_bucket` | `linode_object_storage_bucket` |
| `linode_object_storage_key` | `linode_object_storage_key` |
| `linode_placement_group` | `linode_placement_group` |
| `linode_placement_group_assignment` | `linode_placement_group_assignment` |
| `linode_rdns` | `linode_rdns` |
| `linode_reserved_ip_assignment` | `linode_reserved_ip_assignment` |
| `linode_sshkey` | `linode_sshkey` |
| `linode_stackscript` | `linode_stackscript` |
| `linode_token` | `linode_token` |
| `linode_user` | `linode_user` |
| `linode_volume` | `linode_volume` |
| `linode_volume_protected` | `linode_volume` (delete-protected) |
| `linode_vpc` | `linode_vpc` |
| `linode_vpc_subnet` | `linode_vpc_subnet` |

## Usage

```hcl
module "volumes" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_volume?ref=v0.1.0"

  volumes = {
    data = { label = "data", region = "us-east", size = 20 }
  }
}
```

## Requirements

- **Terraform >= 1.7**.
- The **`linode/linode`** provider (`~> 3.0`) — published on the Terraform
  Registry, so no special setup is needed; `terraform init` fetches it.

## Development

Modules are plan-tested with Terraform's native test framework, credential-free
(`mock_provider`, `command = plan`). `terraform init` fetches the provider
schema from the Registry (no Linode token):

```sh
terraform -chdir=modules/linode_volume init
terraform -chdir=modules/linode_volume test
```

See [`.claude/TESTS.md`](.claude/TESTS.md).

[ln]: https://www.linode.com
[prov]: https://registry.terraform.io/providers/linode/linode/latest
[hd]: https://github.com/harleypig/harleydev
