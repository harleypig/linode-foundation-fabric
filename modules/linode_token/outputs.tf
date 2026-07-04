output "id" {
  description = "The ID of the token."
  value       = linode_token.this.id
}

output "label" {
  description = "The label of the Linode Token."
  value       = linode_token.this.label
}

output "scopes" {
  description = "The scopes this token was created with."
  value       = linode_token.this.scopes
}

output "created" {
  description = "The date and time this token was created."
  value       = linode_token.this.created
}

output "expiry" {
  description = "When this token will expire."
  value       = linode_token.this.expiry
}

output "token" {
  description = "The token used to access the API."
  value       = linode_token.this.token
  sensitive   = true
}
