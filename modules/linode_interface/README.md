# Linode Interface Terraform Module

This module manages a single `linode_interface` — a network interface attached
to a Linode instance. An interface is exactly one of three kinds: `public`,
`vlan`, or `vpc`; supply the matching block and leave the others null.

## Usage

```hcl
module "interface" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_interface?ref=v2.0.0"

  linode_id = 12345

  # A public interface with auto-assigned IPv4/IPv6 addresses.
  public = {}
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
| [linode_interface.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to assign this interface to. | `number` | n/a | yes |
| <a name="input_default_route"></a> [default\_route](#input\_default\_route) | Indicates if the interface serves as the default route when multiple interfaces are eligible for this role. | <pre>object({<br/>    ipv4 = optional(bool)<br/>    ipv6 = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_firewall_id"></a> [firewall\_id](#input\_firewall\_id) | ID of an enabled firewall to secure a VPC or public interface. Not allowed for VLAN interfaces. | `number` | `null` | no |
| <a name="input_public"></a> [public](#input\_public) | Linode public interface. Mutually exclusive with vlan and vpc. Pass an empty object ({}) for a public interface with auto-assigned addresses. | <pre>object({<br/>    ipv4 = optional(object({<br/>      addresses = optional(list(object({<br/>        address = optional(string)<br/>        primary = optional(bool)<br/>      })))<br/>    }))<br/>    ipv6 = optional(object({<br/>      ranges = optional(list(object({<br/>        range = string<br/>      })))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | Linode VLAN interface. Mutually exclusive with public and vpc. | <pre>object({<br/>    vlan_label   = string<br/>    ipam_address = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Linode VPC interface. Mutually exclusive with public and vlan. | <pre>object({<br/>    subnet_id = number<br/>    ipv4 = optional(object({<br/>      addresses = optional(list(object({<br/>        address         = optional(string)<br/>        nat_1_1_address = optional(string)<br/>        primary         = optional(bool)<br/>      })))<br/>      ranges = optional(list(object({<br/>        range = string<br/>      })))<br/>    }))<br/>    ipv6 = optional(object({<br/>      is_public = optional(bool)<br/>      ranges = optional(list(object({<br/>        range = optional(string)<br/>      })))<br/>      slaac = optional(list(object({<br/>        range = optional(string)<br/>      })))<br/>    }))<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_route"></a> [default\_route](#output\_default\_route) | Whether the interface serves as the IPv4 and/or IPv6 default route. |
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | ID of the firewall securing this VPC or public interface, if any. |
| <a name="output_id"></a> [id](#output\_id) | The unique ID for this interface. |
| <a name="output_linode_id"></a> [linode\_id](#output\_linode\_id) | The ID of the Linode this interface is assigned to. |
| <a name="output_public"></a> [public](#output\_public) | The resolved public interface configuration, including assigned addresses. |
| <a name="output_vlan"></a> [vlan](#output\_vlan) | The resolved VLAN interface configuration. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | The resolved VPC interface configuration, including assigned addresses and ranges. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- `public`, `vlan`, and `vpc` are mutually exclusive — set exactly one. The
  Linode API rejects an interface that specifies more than one kind.
- `firewall_id` may secure a `public` or `vpc` interface but is not allowed on
  a `vlan` interface.
- Pass `public = {}` for a public interface with auto-assigned addresses; the
  provider computes the resulting `ipv4`/`ipv6` assignments (surfaced via the
  `public` output).
- Computed results such as assigned addresses and ranges are exposed as
  outputs (`public`, `vpc`, `default_route`); they are not inputs.
