<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_instance_config.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance_config) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_label"></a> [label](#input\_label) | The Config’s label for display purposes only. | `string` | n/a | yes |
| <a name="input_linode_id"></a> [linode\_id](#input\_linode\_id) | The ID of the Linode to create this configuration profile under. | `number` | n/a | yes |
| <a name="input_booted"></a> [booted](#input\_booted) | If true, the Linode will be booted into this config. | `bool` | `true` | no |
| <a name="input_comments"></a> [comments](#input\_comments) | Optional field for arbitrary User comments on this Config. | `string` | `null` | no |
| <a name="input_devices"></a> [devices](#input\_devices) | A list of device configurations for the Linode instance. | <pre>list(object({<br/>    device_name = string<br/>    disk_id     = optional(number)<br/>    volume_id   = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_helpers"></a> [helpers](#input\_helpers) | Helpers enabled when booting to this Linode Config. | `map(bool)` | `{}` | no |
| <a name="input_interface"></a> [interface](#input\_interface) | An array of Network Interfaces to use for this Configuration Profile. | <pre>list(object({<br/>    purpose      = string<br/>    ipam_address = optional(string)<br/>    label        = optional(string)<br/>    subnet_id    = optional(string)<br/>    primary      = optional(bool)<br/>    ipv4 = optional(object({<br/>      vpc     = optional(string)<br/>      nat_1_1 = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_kernel"></a> [kernel](#input\_kernel) | A Kernel ID to boot a Linode with. Default is linode/latest-64bit. | `string` | `"linode/latest-64bit"` | no |
| <a name="input_memory_limit"></a> [memory\_limit](#input\_memory\_limit) | The memory limit of the Config. Defaults to the total ram of the Linode. | `number` | `null` | no |
| <a name="input_root_device"></a> [root\_device](#input\_root\_device) | The root device to boot. (default /dev/sda) | `string` | `"/dev/sda"` | no |
| <a name="input_run_level"></a> [run\_level](#input\_run\_level) | Defines the state of your Linode after booting. (default, single, binbash) | `string` | `"default"` | no |
| <a name="input_virt_mode"></a> [virt\_mode](#input\_virt\_mode) | Controls the virtualization mode. (paravirt, fullvirt) | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->