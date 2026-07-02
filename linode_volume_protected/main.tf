# Protected variant of ../linode_volume: identical in every way except the
# `lifecycle { prevent_destroy = true }` guard below. It exists as a separate
# module because Terraform requires the `prevent_destroy` meta-argument to be
# a literal — it cannot be driven by a variable — so a shared module cannot
# toggle protection per instance. The base module stays destroyable (e.g.
# servers/ server_volumes, which are recreated with their server); this
# variant is for volumes holding irreplaceable data (harleypig-com-data).
#
# Keep variables.tf / outputs.tf / provider.tf in sync with ../linode_volume;
# only this file (the lifecycle block) is meant to differ.
resource "linode_volume" "this" {
  label     = var.label
  size      = var.size
  region    = var.region
  linode_id = var.linode_id
  tags      = var.tags

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
