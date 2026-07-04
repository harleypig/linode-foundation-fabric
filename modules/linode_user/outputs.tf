output "id" {
  description = "The unique ID of this user (the username)."
  value       = linode_user.this.id
}

output "username" {
  description = "The username of the user."
  value       = linode_user.this.username
}

output "email" {
  description = "The email of the user."
  value       = linode_user.this.email
}

output "restricted" {
  description = "Whether the user must be explicitly granted access to platform actions and entities."
  value       = linode_user.this.restricted
}

output "ssh_keys" {
  description = "SSH keys on the user's profile."
  value       = linode_user.this.ssh_keys
}

output "tfa_enabled" {
  description = "Whether the user has Two Factor Authentication (TFA) enabled."
  value       = linode_user.this.tfa_enabled
}

output "user_type" {
  description = "The type of this user."
  value       = linode_user.this.user_type
}
