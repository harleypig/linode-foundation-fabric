# Linode Object Storage Bucket Terraform Module

Creates and manages a single Linode Object Storage bucket.

It has **no consumer in this repo yet** — the Terraform state bucket itself is
created out of band by `bin/setup-bucket` (a state bucket can't be managed by a
config whose state lives inside it; see `docs/backend-storage.md`). This module
is retained for future Object Storage needs (Track C).

## Usage

```hcl
module "state_bucket" {
  source = "../tfmods/linode_object_storage_bucket"

  region = "us-east-1"
  label  = "harleypig-terraform-state"
}
```

## Notes

- **Region IDs differ from compute regions.** Object Storage uses the
  cluster-style id (`us-east-1`, `eu-central-1`), which matches the bucket's
  S3 endpoint host (`us-east-1` → `us-east-1.linodeobjects.com`). The compute
  modules' region list (`us-east`, …) does **not** apply here.
- **Private by default.** The bucket inherits the provider's default `private`
  ACL — appropriate for a state bucket. Versioning, lifecycle rules, and other
  hardening are intentionally out of scope here; they are tracked under the
  security-hardening roadmap track (see `docs/ROADMAP.md`).
- **Authentication.** Bucket operations authenticate with an Object Storage
  access key (separate from the Linode API token); see
  `docs/backend-storage.md`.

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
| [linode_object_storage_bucket.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/object_storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The globally-unique name (label) of the bucket. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Object Storage region (cluster) the bucket lives in, e.g. us-east-1. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The hostname where this bucket can be accessed (label.region.linodeobjects.com). |
| <a name="output_id"></a> [id](#output\_id) | The unique ID of this bucket. |
| <a name="output_label"></a> [label](#output\_label) | The label of the bucket. |
| <a name="output_region"></a> [region](#output\_region) | The region (cluster) the bucket resides in. |
| <a name="output_s3_endpoint"></a> [s3\_endpoint](#output\_s3\_endpoint) | The S3 endpoint URL for the bucket. |
<!-- END_TF_DOCS -->
