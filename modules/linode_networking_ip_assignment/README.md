# Linode Networking IP Assignment Terraform Module

Manages the assignment of IP addresses to Linodes within a region via the
`linode_networking_ip_assignment` resource. Each entry in `assignments` moves
the given IP address onto the specified Linode, applied as a single regional
operation.

## Usage

```hcl
module "networking_ip_assignment" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_networking_ip_assignment?ref=v2.0.0"

  region = "us-east"

  assignments = [{
    address   = "192.0.2.10"
    linode_id = 12345
  }]
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
| [linode_networking_ip_assignment.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/networking_ip_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The region for the IP assignments. | `string` | n/a | yes |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | The list of IP-to-Linode assignments to apply in the region. Each entry moves the given IP address to the specified Linode. | <pre>list(object({<br/>    address   = string<br/>    linode_id = number<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the IP assignment operation. |
| <a name="output_region"></a> [region](#output\_region) | The region the IP assignments were applied in. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- All IP addresses and Linodes referenced in `assignments` must reside in the
  same `region`; the operation is regional and the provider rejects
  cross-region assignments.
- The addresses supplied must already be allocated to the account (e.g. via an
  IP reservation or an existing Linode); this resource reassigns existing IPs
  rather than allocating new ones.
