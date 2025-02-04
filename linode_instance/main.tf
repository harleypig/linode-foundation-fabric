# Make this resource use the appropriate variables for each options, AI!
resource "linode_instance" "site" {
  label = var.label
  #image  = "linode/arch"
  region = var.region
  type   = var.type
  #migration_type = "cold"
  #resize_disk    = false
  backups_enabled = var.backups
  alert = var.alert
  tags = var.tags
}