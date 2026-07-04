# Linode Instance Shared IPs Terraform Module

This module shares a set of IP addresses with a Linode instance, wrapping the
single `linode_instance_shared_ips` resource. IP sharing underpins failover
setups where a floating address moves between instances.

## Usage

```hcl
module "instance_shared_ips" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_instance_shared_ips?ref=v0.2.0"

  linode_id = 12345
  addresses = [
    "192.0.2.10",
    "2600:3c00::f03c:0:0:1",
  ]
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
| [linode_instance_shared_ips.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance_shared_ips) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addresses"></a> [addresses](#input\_addresses) | A set of IP addresses to share to the Linode. | `set(string)` | n/a | yes |
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to share these IP addresses with. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addresses"></a> [addresses](#output\_addresses) | The set of IP addresses shared to the Linode. |
| <a name="output_id"></a> [id](#output\_id) | The ID of this resource (the linode\_id of the target Linode). |
| <a name="output_linode_id"></a> [linode\_id](#output\_linode\_id) | The ID of the Linode the IP addresses are shared with. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- The IP addresses must already be allocated on the account (e.g. reserved IPs
  or addresses assigned to another Linode); this resource only shares existing
  addresses, it does not allocate new ones.
- The set of `addresses` is authoritative — the shared set is replaced to match
  on each apply, so list every address that should remain shared.
- The resource `id` is the target Linode's ID, not a distinct identifier.
