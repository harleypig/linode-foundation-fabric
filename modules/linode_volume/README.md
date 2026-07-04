# Linode Volume Terraform Module

This module creates and manages Linode volumes with optional attachment to instances.

## Usage

```hcl
module "volume" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_volume?ref=v0.2.0"

  label     = "my-volume"
  size      = 50
  region    = "us-central"
  linode_id = 12345  # Optional - for immediate attachment
  tags      = ["storage", "production"]
}
```

## Volume Resizing

This module supports volume resizing by updating the `size` parameter.

### Restrictions

- **Volumes can only be increased in size** - Linode does not support shrinking volumes
- Minimum size: 10 GB
- Maximum size: 10,240 GB (10 TB)
- Resizing can be performed while the volume is attached and in use

### Filesystem Expansion

**Note**: If using the golden image with automatic volume management, filesystem expansion is handled automatically. The system detects volume resizes and expands the filesystem without manual intervention.

For manual expansion (if not using the golden image):

```bash
# For ext4 filesystems
sudo resize2fs /dev/disk/by-id/scsi-0Linode_Volume_volume-label

# For XFS filesystems
sudo xfs_growfs /mnt/volume-mount-point
```

### Resize Example

```hcl
# Before
module "volume" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_volume?ref=v0.2.0"

  label = "my-volume"
  size  = 25  # GB
  region = "us-central"
}

# After - resize to 50 GB
module "volume" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_volume?ref=v0.2.0"

  label = "my-volume"
  size  = 50  # Increased from 25 GB
  region = "us-central"

  timeouts = {
    update = "15m"  # Optional: longer timeout for large resizes
  }
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

## Notes

- Volumes created without a `linode_id` are unattached and can be attached later
- Use `linode_volume_attachment` resource for attaching existing volumes
- Volume labels must be unique within your Linode account
- Filesystem expansion after resizing must be handled separately
