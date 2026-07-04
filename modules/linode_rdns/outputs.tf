output "rdns_ids" {
  value       = { for key, record in linode_rdns.rdns : key => record.id }
  description = "A map of RDNS keys to their respective Linode RDNS record IDs."
}
