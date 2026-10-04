# Protected variant of ../linode_instance: identical in every way except the
# `lifecycle` block at the bottom. It is a separate module because
# `prevent_destroy` and `ignore_changes` must be literals in the resource
# block; a variable cannot drive them and a module call cannot carry them, so
# one shared module cannot toggle protection per instance.
#
# Keep variables.tf / outputs.tf / provider.tf in sync with ../linode_instance;
# only this file (the lifecycle block) is meant to differ.
locals {
  # An empty set is sent as null: [] reads as a change from the instance's
  # current addresses and, ipv4 being ForceNew, would replace it.
  ipv4 = length(coalesce(var.ipv4, [])) > 0 ? var.ipv4 : null
}

resource "linode_instance" "instance" {
  region                             = var.region
  type                               = var.type
  label                              = var.label
  tags                               = var.tags
  private_ip                         = var.private_ip
  shared_ipv4                        = var.shared_ipv4
  ipv4                               = local.ipv4
  image                              = var.image
  root_pass                          = var.root_pass
  authorized_keys                    = var.authorized_keys
  authorized_users                   = var.authorized_users
  stackscript_id                     = var.stackscript_id
  stackscript_data                   = var.stackscript_data
  swap_size                          = var.swap_size
  backups_enabled                    = var.backups_enabled
  watchdog_enabled                   = var.watchdog_enabled
  booted                             = var.booted
  migration_type                     = var.migration_type
  firewall_id                        = var.firewall_id
  disk_encryption                    = var.disk_encryption
  backup_id                          = var.backup_id
  resize_disk                        = var.resize_disk
  placement_group_externally_managed = var.placement_group_externally_managed

  dynamic "metadata" {
    for_each = var.metadata != null ? [var.metadata] : []
    content {
      user_data = base64encode(metadata.value.user_data)
    }
  }

  dynamic "placement_group" {
    for_each = var.placement_group_id != null ? [var.placement_group_id] : []
    content {
      id = placement_group.value
    }
  }

  dynamic "alerts" {
    for_each = var.alerts != null ? [var.alerts] : []
    content {
      cpu            = alerts.value.cpu
      network_in     = alerts.value.network_in
      network_out    = alerts.value.network_out
      transfer_quota = alerts.value.transfer_quota
      io             = alerts.value.io
    }
  }

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

    # Read once, when the instance and its boot disk are created, and ForceNew
    # in the provider (schema_resource.go, every release v4.0.0-v4.7.0). The
    # provider never reads them back, ipv4 aside. A later change to any of
    # them is never applied to the running server -- the provider's only
    # response is to replace it -- so it is ignored here instead of letting
    # prevent_destroy fail the plan. A deliberate rebuild is in the README.
    #
    # root_pass is not ForceNew, but the provider applies a change by powering
    # the server off, resetting the password and booting it again, so a drifted
    # or regenerated value would take the server down on an ordinary apply. It
    # is the initial password; rotating it is the host's job.
    #
    # Left out on purpose: type and region (resized or migrated in place), and
    # disk_encryption (ForceNew, but ignoring it would leave config claiming an
    # encryption state the disk does not have, so the plan is left to fail on
    # prevent_destroy instead).
    ignore_changes = [
      metadata,         # cloud-init user_data: consumed at first boot only
      authorized_keys,  # written to root's authorized_keys at disk deploy
      authorized_users, # same, from the users' Linode profile keys
      image,            # the boot disk's source image, used at deploy
      stackscript_id,   # run once, at deploy
      stackscript_data, # that StackScript's inputs
      backup_id,        # the backup restored at creation
      ipv4,             # create-time address; later IPs are other resources
      firewall_id,      # create-time attachment; later via firewall devices
      root_pass,        # see above: a change power-cycles the server
    ]
  }
}
