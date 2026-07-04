# Linode Firewall Device Terraform Module

This module manages a single Linode Firewall Device — the attachment binding
one entity (a Linode instance or NodeBalancer) to an existing Cloud Firewall.
It manages only the device link; the Firewall and the entity are created
elsewhere and referenced here by ID.

## Usage

```hcl
module "firewall_device" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_firewall_device?ref=v1.0.0"

  firewall_id = 123456
  entity_id   = 654321
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
| [linode_firewall_device.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/firewall_device) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_entity_id"></a> [entity\_id](#input\_entity\_id) | The ID of the entity to create a Firewall device for. | `number` | n/a | yes |
| <a name="input_firewall_id"></a> [firewall\_id](#input\_firewall\_id) | The ID of the Firewall to access. | `number` | n/a | yes |
| <a name="input_entity_type"></a> [entity\_type](#input\_entity\_type) | The type of the entity to create a Firewall device for. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | When this Firewall Device was created. |
| <a name="output_entity_type"></a> [entity\_type](#output\_entity\_type) | The type of the entity the Firewall device was created for. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID that represents the firewall device in the Terraform state. |
| <a name="output_updated"></a> [updated](#output\_updated) | When this Firewall Device was updated. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `entity_type` is optional and computed — the provider derives it from
  `entity_id` when omitted. Set it explicitly only when disambiguation is
  needed; valid values are `linode` and `nodebalancer`.
- One firewall device attaches exactly one entity. To attach several entities
  to a Firewall, the caller composes this module with its own `for_each`.
- Destroying this resource detaches the entity from the Firewall; it does not
  delete the Firewall or the entity.
