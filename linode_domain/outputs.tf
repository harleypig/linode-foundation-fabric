output "domain_ids" {
  value = { for domain, details in linode_domain.domains : details.domain_index => d.id }
  description = "A map of domain names to their respective Linode domain IDs."
}
