resource "linode_stackscript" "this" {
  label       = var.label
  description = var.description
  images      = var.images
  script      = var.script
  is_public   = var.is_public
  rev_note    = var.rev_note
}
