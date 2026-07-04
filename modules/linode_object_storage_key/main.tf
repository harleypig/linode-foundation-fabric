resource "linode_object_storage_key" "this" {
  label   = var.label
  regions = var.regions

  dynamic "bucket_access" {
    for_each = var.bucket_access
    content {
      bucket_name = bucket_access.value.bucket_name
      permissions = bucket_access.value.permissions
      region      = bucket_access.value.region
    }
  }
}
