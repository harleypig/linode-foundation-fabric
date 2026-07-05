# Linode Lock Terraform Module

This module manages a Linode lock that prevents accidental **deletion,
rebuild, and account transfer** of a resource, wrapping the single
`linode_lock` resource. The lock is enforced on the Linode side, so it guards
against deletion by any path (Cloud Manager, API, CLI, or Terraform), not just
Terraform.

> **Early access.** `linode_lock` is an early-access provider resource and may
> change. It targets the beta API, so the consuming configuration must set
> `api_version = "v4beta"` on the `linode` provider — otherwise the provider
> emits a "Non-Beta Target API Version" warning and the lock may not apply.

## Usage

```hcl
provider "linode" {
  api_version = "v4beta" # linode_lock is early access; it targets the beta API
}

module "lock" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_lock?ref=v2.1.0"

  entity_id   = linode_volume.data.id
  entity_type = "volume"
  lock_type   = "cannot_delete_with_subresources"
}
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_lock.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lock) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_entity_id"></a> [entity\_id](#input\_entity\_id) | The ID of the entity to lock (a Linode, NodeBalancer, Block Storage volume, LKE cluster, or LKE node pool). | `number` | n/a | yes |
| <a name="input_entity_type"></a> [entity\_type](#input\_entity\_type) | The type of the entity to lock. Note: a Linode that is part of an LKE cluster cannot be locked. | `string` | n/a | yes |
| <a name="input_lock_type"></a> [lock\_type](#input\_lock\_type) | The type of lock to apply. `cannot_delete` prevents deletion, rebuild, and account transfer; `cannot_delete_with_subresources` additionally protects subresources (disks, configs, interfaces, IP addresses) but does NOT apply to an lkecluster or lkenodepool. Only one lock can exist per resource at a time. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_entity_id"></a> [entity\_id](#output\_entity\_id) | The ID of the locked entity. |
| <a name="output_entity_label"></a> [entity\_label](#output\_entity\_label) | The label of the locked entity. |
| <a name="output_entity_type"></a> [entity\_type](#output\_entity\_type) | The type of the locked entity. |
| <a name="output_entity_url"></a> [entity\_url](#output\_entity\_url) | The URL of the locked entity. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of the lock. |
| <a name="output_lock_type"></a> [lock\_type](#output\_lock\_type) | The type of lock applied to the entity. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- **Early access / beta API.** The resource is early access and targets the
  beta API. Set `api_version = "v4beta"` on the `linode` provider (see *Usage*);
  without it the provider warns "Non-Beta Target API Version" and the lock may
  not apply. Being early access, the resource's schema may change.
- **Only unrestricted (full-access) users can create or delete locks.** A
  restricted user/token cannot manage locks even with read/write on the
  resource.
- **One lock per resource** — `cannot_delete` and
  `cannot_delete_with_subresources` are mutually exclusive on the same entity.
- **`cannot_delete_with_subresources` does not apply to `lkecluster` /
  `lkenodepool`** — use `cannot_delete` for those. A Linode that is part of an
  LKE cluster cannot be locked at all.
- **Terraform teardown is a two-step.** While the lock exists, any operation
  that would delete, rebuild, or transfer the locked entity fails at the API —
  including `terraform destroy` or a plan that forces its replacement. To
  intentionally remove the entity, destroy this `linode_lock` first, then the
  entity. That is the safety feature working as intended.
- Import an existing lock by its ID: `terraform import linode_lock.this 1234567`.
