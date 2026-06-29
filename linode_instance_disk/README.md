<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_instance_disk.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance_disk) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The Disk's label for display purposes only. | `string` | n/a | yes |
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to create this Disk under. | `number` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | The size of the Disk in MB. | `number` | n/a | yes |
| <a name="input_authorized_keys"></a> [authorized\_keys](#input\_authorized\_keys) | A list of public SSH keys that will be automatically appended to the root user's ~/.ssh/authorized\_keys file when deploying from an Image. | `list(string)` | `[]` | no |
| <a name="input_authorized_users"></a> [authorized\_users](#input\_authorized\_users) | A list of usernames. If the usernames have associated SSH keys, the keys will be appended to the root user's ~/.ssh/authorized\_keys file. | `list(string)` | `[]` | no |
| <a name="input_filesystem"></a> [filesystem](#input\_filesystem) | The filesystem of this disk. (raw, swap, ext3, ext4, initrd) | `string` | `"ext4"` | no |
| <a name="input_image"></a> [image](#input\_image) | An Image ID to deploy the Linode Disk from. | `string` | `null` | no |
| <a name="input_root_pass"></a> [root\_pass](#input\_root\_pass) | The root user's password on a newly-created Linode Disk when deploying from an Image. | `string` | `null` | no |
| <a name="input_stackscript_data"></a> [stackscript\_data](#input\_stackscript\_data) | An object containing responses to any User Defined Fields present in the StackScript being deployed to this Disk. | `map(any)` | `{}` | no |
| <a name="input_stackscript_id"></a> [stackscript\_id](#input\_stackscript\_id) | A StackScript ID that will cause the referenced StackScript to be run during deployment of this Disk. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | When this disk was created. |
| <a name="output_disk_encryption"></a> [disk\_encryption](#output\_disk\_encryption) | The disk encryption policy for this disk's parent instance. |
| <a name="output_status"></a> [status](#output\_status) | A brief description of this Disk's current state. |
| <a name="output_updated"></a> [updated](#output\_updated) | When this disk was last updated. |
<!-- END_TF_DOCS -->