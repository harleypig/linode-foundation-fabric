output "id" {
  description = "The unique ID of this SSH key."
  value       = linode_sshkey.this.id
}

output "label" {
  description = "The label of the SSH key."
  value       = linode_sshkey.this.label
}

output "ssh_key" {
  description = "The public SSH key."
  value       = linode_sshkey.this.ssh_key
}

output "created" {
  description = "The date this key was added."
  value       = linode_sshkey.this.created
}
