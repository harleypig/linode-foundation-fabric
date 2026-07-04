# Linode Firewall Settings Terraform Module

This module manages account-level default firewall settings, assigning the
default Cloud Firewall applied to newly created Linodes, NodeBalancers, and
public/VPC interfaces. It wraps a single `linode_firewall_settings` resource.

## Usage

```hcl
module "firewall_settings" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_firewall_settings?ref=v2.0.0"

  default_firewall_ids = {
    linode           = 12345
    nodebalancer     = 12346
    public_interface = 12347
    vpc_interface    = 12348
  }
}
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_firewall_settings.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/firewall_settings) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_firewall_ids"></a> [default\_firewall\_ids](#input\_default\_firewall\_ids) | The default firewall ID for a linode, nodebalancer, public\_interface, or vpc\_interface. Any field left unset is left to the account's computed default. | <pre>object({<br/>    linode           = optional(number)<br/>    nodebalancer     = optional(number)<br/>    public_interface = optional(number)<br/>    vpc_interface    = optional(number)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_firewall_ids"></a> [default\_firewall\_ids](#output\_default\_firewall\_ids) | The resolved default firewall IDs for the linode, nodebalancer, public\_interface, and vpc\_interface. |
| <a name="output_id"></a> [id](#output\_id) | A unique identifier for this resource (UUID v7). |
| <a name="output_linode_default_firewall_id"></a> [linode\_default\_firewall\_id](#output\_linode\_default\_firewall\_id) | The Linode's default firewall. |
| <a name="output_nodebalancer_default_firewall_id"></a> [nodebalancer\_default\_firewall\_id](#output\_nodebalancer\_default\_firewall\_id) | The NodeBalancer's default firewall. |
| <a name="output_public_interface_default_firewall_id"></a> [public\_interface\_default\_firewall\_id](#output\_public\_interface\_default\_firewall\_id) | The public interface's default firewall. |
| <a name="output_vpc_interface_default_firewall_id"></a> [vpc\_interface\_default\_firewall\_id](#output\_vpc\_interface\_default\_firewall\_id) | The VPC interface's default firewall. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- This is an **account-level** singleton — there is one firewall-settings
  object per account. Manage it from a single module instance; do not create
  more than one.
- Every field of `default_firewall_ids` is optional and computed: any field
  left unset is resolved to the account's existing default rather than being
  cleared. Reference an existing `linode_firewall` resource's `id` to wire a
  managed firewall in as a default.
