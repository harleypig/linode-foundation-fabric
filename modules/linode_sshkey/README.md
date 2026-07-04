# Linode SSH Key Terraform Module

This module manages a single Linode account SSH key (a public key made
available to instances at deploy time via `authorized_keys`). It does not
generate keys — supply an existing public key.

## Usage

```hcl
module "sshkey" {
  source  = "../tfmods/linode_sshkey"
  label   = "harleypig-laptop"
  ssh_key = chomp(file("~/.ssh/id_ed25519.pub"))
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
| [linode_sshkey.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/sshkey) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | A label for the SSH key, for display purposes. | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | The public SSH key used to authenticate to the root user of deployed Linodes. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | The date this key was added. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this SSH key. |
| <a name="output_label"></a> [label](#output\_label) | The label of the SSH key. |
| <a name="output_ssh_key"></a> [ssh\_key](#output\_ssh\_key) | The public SSH key. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- Linode SSH keys are account-level (under your Profile), not per-instance.
- `ssh_key` must be a public key; the module never generates one.
- Reference the key on an instance via `authorized_keys = [module.sshkey.ssh_key]`.
