output "username" {
  description = "The username of the IAM user."
  value       = linode_iam_user.this.username
}

output "account_access" {
  description = "The user account level access."
  value       = linode_iam_user.this.account_access
}

output "entity_access" {
  description = "The user entity level access."
  value       = linode_iam_user.this.entity_access
}
