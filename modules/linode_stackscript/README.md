# Linode StackScript Terraform Module

This module creates and manages a single Linode StackScript — a saved boot
script that can be selected when deploying a Linode to automate its initial
provisioning.

## Usage

```hcl
module "stackscript" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_stackscript?ref=v1.0.0"

  label       = "example-stackscript"
  description = "Installs and configures example software on first boot."
  images      = ["linode/ubuntu22.04"]
  script      = <<-EOT
    #!/bin/bash
    # <UDF name="hostname" label="Hostname" />
    apt-get update
  EOT
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
| [linode_stackscript.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/stackscript) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description for the StackScript. | `string` | n/a | yes |
| <a name="input_images"></a> [images](#input\_images) | An array of Image IDs representing the Images that this StackScript is compatible for deploying with. | `set(string)` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | The StackScript's label is for display purposes only. | `string` | n/a | yes |
| <a name="input_script"></a> [script](#input\_script) | The script to execute when provisioning a new Linode with this StackScript. | `string` | n/a | yes |
| <a name="input_is_public"></a> [is\_public](#input\_is\_public) | This determines whether other users can use your StackScript. Once a StackScript is made public, it cannot be made private. | `bool` | `false` | no |
| <a name="input_rev_note"></a> [rev\_note](#input\_rev\_note) | This field allows you to add notes for the set of revisions made to this StackScript. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | The date this StackScript was created. |
| <a name="output_deployments_active"></a> [deployments\_active](#output\_deployments\_active) | Count of currently active, deployed Linodes created from this StackScript. |
| <a name="output_deployments_total"></a> [deployments\_total](#output\_deployments\_total) | The total number of times this StackScript has been deployed. |
| <a name="output_id"></a> [id](#output\_id) | The StackScript's unique ID. |
| <a name="output_is_public"></a> [is\_public](#output\_is\_public) | Whether other users can use this StackScript. |
| <a name="output_label"></a> [label](#output\_label) | The StackScript's label. |
| <a name="output_updated"></a> [updated](#output\_updated) | The date this StackScript was updated. |
| <a name="output_user_defined_fields"></a> [user\_defined\_fields](#output\_user\_defined\_fields) | A list of fields defined with a special syntax inside this StackScript that allow for supplying customized parameters during deployment. |
| <a name="output_user_gravatar_id"></a> [user\_gravatar\_id](#output\_user\_gravatar\_id) | The Gravatar ID for the User who created the StackScript. |
| <a name="output_username"></a> [username](#output\_username) | The User who created the StackScript. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `script` must begin with a shebang line (e.g. `#!/bin/bash`).
- `images` are Image IDs the StackScript is compatible with, each of the form
  `<vendor>/<image>` (e.g. `linode/ubuntu22.04`, `any/all`).
- `is_public` is a one-way switch: once a StackScript is made public it cannot
  be made private again.
- User Defined Fields (UDFs) declared inline in `script` are parsed by Linode
  and surfaced read-only via the `user_defined_fields` output.
