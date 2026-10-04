# Protected variant of ../linode_reserved_ip: identical in every way except
# the `lifecycle { prevent_destroy = true }` guard below. It is a separate
# module because Terraform requires `prevent_destroy` to be a literal; a
# variable cannot drive it, so one shared module cannot toggle protection per
# instance.
#
# Keep variables.tf / outputs.tf / provider.tf in sync with
# ../linode_reserved_ip; only this file (the lifecycle block) is meant to
# differ.
resource "linode_reserved_ip" "this" {
  region = var.region
  tags   = var.tags

  lifecycle {
    prevent_destroy = true
  }
}
