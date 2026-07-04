# Linode Volume (Protected) Terraform Module

The `prevent_destroy` variant of [`../linode_volume`](../linode_volume). It is
identical to the base module in every input, output, and resource — the only
difference is a `lifecycle { prevent_destroy = true }` guard on the volume, so
Terraform **refuses to destroy or replace it** and errors on any plan that
would.

Use it for volumes holding irreplaceable data (e.g. `harleypig-com-data`).
The base module stays destroyable for volumes that are recreated with their
server (`servers/` `server_volumes`).

## Why a separate module

Terraform requires the `prevent_destroy` meta-argument to be a **literal** —
it cannot be set from a variable — so a single shared module cannot toggle
protection per instance. A distinct module is the only way to express "this
volume is protected, that one is not". Keep `variables.tf`, `outputs.tf`, and
`provider.tf` byte-identical to `../linode_volume` (a `diff` should be empty);
only `main.tf` is meant to differ.

## Protecting an existing volume (state move)

Routing a volume that already exists in state to this module changes its
resource address (`module.<x>[...]` → `module.<protected>[...]`), which
Terraform would otherwise read as destroy-and-recreate. Add a `moved` block in
the consuming config so the state address is updated in place — see
`volumes/main.tf` for the `harleypig-com-data` example. Confirm with
`terraform plan` that the result is a move with **0 to destroy** before
applying.

For inputs, outputs, and volume-resizing behaviour, see
[`../linode_volume`](../linode_volume) — they are shared.

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
| [linode_volume.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label of the Linode Volume. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where this volume will be deployed. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Size of the Volume in GB. | `number` | n/a | yes |
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The Linode ID to attach the volume to. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | An array of tags applied to this object. | `list(string)` | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | The timeouts configuration for the Linode volume. | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_filesystem_path"></a> [filesystem\_path](#output\_filesystem\_path) | The full filesystem path for the Volume based on the Volume's label. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this Volume. |
| <a name="output_label"></a> [label](#output\_label) | The label of the Linode Volume. |
| <a name="output_linode_id"></a> [linode\_id](#output\_linode\_id) | If a volume is attached to a specific Linode, the ID of that Linode will be displayed here. |
| <a name="output_region"></a> [region](#output\_region) | The region where this volume resides. |
| <a name="output_size"></a> [size](#output\_size) | The size of the Volume in GB. |
| <a name="output_status"></a> [status](#output\_status) | The status of the volume, indicating if it's active or if any action is needed. |
| <a name="output_tags"></a> [tags](#output\_tags) | An array of tags applied to this object. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->
