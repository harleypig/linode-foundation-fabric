resource "linode_object_storage_bucket" "this" {
  region = var.region
  label  = var.label
}
