output "domain_ids" {
  value = { for d in linode_domain.domains : d.domain => d.id }
  description = "A map of domain names to their respective Linode domain IDs."
}
