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
| `linode_domain` | `linode_domain` |
| `linode_domain_record` | `linode_domain_record` |
| `linode_firewall` | `linode_firewall` |
| `linode_instance` | `linode_instance` |
| `linode_instance_config` | `linode_instance_config` |
| `linode_instance_disk` | `linode_instance_disk` |
| `linode_instance_ip` | `linode_instance_ip` |
| `linode_object_storage_bucket` | `linode_object_storage_bucket` |
| `linode_rdns` | `linode_rdns` |
| `linode_sshkey` | `linode_sshkey` |
| `linode_volume` | `linode_volume` |
| `linode_volume_protected` | `linode_volume` (delete-protected) |

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
