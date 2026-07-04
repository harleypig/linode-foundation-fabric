# Linode Image Terraform Module

This module creates and manages a single Linode private Image, built either
from an existing Linode disk (`disk_id`, optionally with `linode_id`) or
uploaded from a file (`file_path`/`file_hash` to a `region`), with optional
multi-region replication.

## Usage

```hcl
module "image" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_image?ref=v1.0.0"

  label     = "my-golden-image"
  linode_id = 12345
  disk_id   = 67890
  tags      = ["golden", "production"]
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
| [linode_image.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/image) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | A short description of the Image. Labels cannot contain special characters. | `string` | n/a | yes |
| <a name="input_cloud_init"></a> [cloud\_init](#input\_cloud\_init) | Whether this image supports cloud-init. | `bool` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A detailed description of this Image. | `string` | `null` | no |
| <a name="input_disk_id"></a> [disk\_id](#input\_disk\_id) | The ID of the Linode Disk that this Image will be created from. | `number` | `null` | no |
| <a name="input_file_hash"></a> [file\_hash](#input\_file\_hash) | The MD5 hash of the image file. | `string` | `null` | no |
| <a name="input_file_path"></a> [file\_path](#input\_file\_path) | The name of the file to upload to this image. | `string` | `null` | no |
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode that this Image will be created from. | `number` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to upload to. | `string` | `null` | no |
| <a name="input_replica_regions"></a> [replica\_regions](#input\_replica\_regions) | A list of regions that customer wants to replicate this image in. At least one available region is required and only core regions allowed. Existing images in the regions not passed will be removed. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The customized tags for the image. | `list(string)` | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | The timeouts configuration for the Linode image. | <pre>object({<br/>    create = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_wait_for_replications"></a> [wait\_for\_replications](#input\_wait\_for\_replications) | Whether to wait for all image replications become `available`. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_capabilities"></a> [capabilities](#output\_capabilities) | The capabilities of this Image. |
| <a name="output_created"></a> [created](#output\_created) | When this Image was created. |
| <a name="output_created_by"></a> [created\_by](#output\_created\_by) | The name of the User who created this Image. |
| <a name="output_deprecated"></a> [deprecated](#output\_deprecated) | Whether or not this Image is deprecated. Will only be True for deprecated public Images. |
| <a name="output_expiry"></a> [expiry](#output\_expiry) | Only Images created automatically (from a deleted Linode; type=automatic) will expire. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Linode image. |
| <a name="output_is_public"></a> [is\_public](#output\_is\_public) | True if the Image is public. |
| <a name="output_is_shared"></a> [is\_shared](#output\_is\_shared) | True if the Image is shared. |
| <a name="output_replications"></a> [replications](#output\_replications) | A list of image replications region and corresponding status. |
| <a name="output_size"></a> [size](#output\_size) | The minimum size this Image needs to deploy. Size is in MB. |
| <a name="output_status"></a> [status](#output\_status) | The current status of this Image. |
| <a name="output_total_size"></a> [total\_size](#output\_total\_size) | The total size of the image in all available regions. |
| <a name="output_type"></a> [type](#output\_type) | How the Image was created. 'Manual' Images can be created at any time. 'Automatic' images are created automatically from a deleted Linode. |
| <a name="output_vendor"></a> [vendor](#output\_vendor) | The upstream distribution vendor. Nil for private Images. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- Provide a source: either `disk_id` (from an existing Linode disk, with
  `linode_id`) **or** `file_path`/`file_hash` for an upload to a `region`.
  The two paths are mutually exclusive.
- `replica_regions` is authoritative: existing replicas in regions **not**
  listed are removed. Leave it `null` to not manage replication at all.
- Image `label` is limited to 50 characters and cannot contain special
  characters.
- All read-only attributes (`size`, `status`, `capabilities`, `created`,
  `is_public`, `replications`, `vendor`, …) are exposed as outputs.
