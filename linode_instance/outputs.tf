output "instance_id" {
  description = "The ID of the Linode instance."
  value       = linode_instance.example.id
}

output "instance_ip_address" {
  description = "The public IP address of the Linode instance."
  value       = linode_instance.example.ip_address
}

output "instance_private_ip_address" {
  description = "The private IP address of the Linode instance, if enabled."
  value       = linode_instance.example.private_ip_address
}

output "instance_status" {
  description = "The status of the Linode instance."
  value       = linode_instance.example.status
}
