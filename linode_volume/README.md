# Linode Volume Terraform Module

This module creates and manages Linode volumes with optional attachment to instances.

## Usage

```hcl
module "volume" {
  source = "./tfmods/linode_volume"
  
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
**Important**: This module only resizes the volume at the block device level. After resizing, you must manually expand the filesystem:

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
  source = "./tfmods/linode_volume"
  
  label = "my-volume"
  size  = 25  # GB
  region = "us-central"
}

# After - resize to 50 GB
module "volume" {
  source = "./tfmods/linode_volume"
  
  label = "my-volume"
  size  = 50  # Increased from 25 GB
  region = "us-central"
  
  timeouts = {
    update = "15m"  # Optional: longer timeout for large resizes
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| label | The label of the Linode Volume | `string` | n/a | yes |
| size | Size of the Volume in GB (10-10240) | `number` | n/a | yes |
| region | The region where this volume will be deployed | `string` | n/a | yes |
| linode_id | The Linode ID to attach the volume to | `number` | `null` | no |
| tags | An array of tags applied to this object | `list(string)` | `[]` | no |
| timeouts | Timeout configuration for volume operations | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The unique ID of this Volume |
| label | The label of the Linode Volume |
| size | The size of the Volume in GB |
| region | The region where this volume resides |
| linode_id | The ID of the attached Linode (if any) |
| filesystem_path | The full filesystem path for the Volume |
| status | The status of the volume |
| tags | An array of tags applied to this object |

## Notes

- Volumes created without a `linode_id` are unattached and can be attached later
- Use `linode_volume_attachment` resource for attaching existing volumes
- Volume labels must be unique within your Linode account
- Filesystem expansion after resizing must be handled separately
