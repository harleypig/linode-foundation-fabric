output "record_ids" {
  value       = { for key, record in linode_domain_record.domain_records : key => record.id }
  description = "A map of record keys to their respective Linode domain record IDs."
}
