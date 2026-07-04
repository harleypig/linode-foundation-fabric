# Linode Object Storage Key Terraform Module

This module manages a single Linode Object Storage key pair (access key +
secret key) used to authenticate against the S3-compatible Object Storage API.
Supply one or more `bucket_access` entries to produce a limited access key
scoped to specific buckets, or omit them for an unrestricted key.

## Usage

```hcl
module "object_storage_key" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_object_storage_key?ref=v0.2.0"

  label = "my-app-storage-key"

  bucket_access = [{
    bucket_name = "my-app-assets"
    permissions = "read_only"
    region      = "us-east"
  }]
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
| [linode_object_storage_key.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/object_storage_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The label given to this key. For display purposes only. | `string` | n/a | yes |
| <a name="input_bucket_access"></a> [bucket\_access](#input\_bucket\_access) | A list of permissions to grant this limited access key. Providing any bucket\_access entries produces a limited access key scoped to those buckets. | <pre>list(object({<br/>    bucket_name = string<br/>    permissions = string<br/>    region      = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | A set of regions where the key will grant access to create buckets. | `set(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key"></a> [access\_key](#output\_access\_key) | This keypair's access key. This is not secret. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this Object Storage key. |
| <a name="output_limited"></a> [limited](#output\_limited) | Whether or not this key is a limited access key. |
| <a name="output_regions"></a> [regions](#output\_regions) | The set of regions where the key grants access to create buckets. |
| <a name="output_regions_details"></a> [regions\_details](#output\_regions\_details) | A set of objects containing the detailed info of the regions where the key grants access. |
| <a name="output_secret_key"></a> [secret\_key](#output\_secret\_key) | This keypair's secret key. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- The `secret_key` is returned **only once**, at creation, and is exposed as a
  sensitive output — capture it then; the Linode API cannot retrieve it later.
- Providing any `bucket_access` entries makes this a *limited access key* (the
  computed `limited` output becomes `true`); omit them for an unrestricted key.
- The `bucket_access.cluster` attribute is deprecated in favor of `region` and
  is intentionally not exposed by this module — use `region` instead.
