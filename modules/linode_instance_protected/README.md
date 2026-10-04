# Linode Instance (Protected) Terraform Module

The protected variant of [`../linode_instance`](../linode_instance). Its
inputs, outputs, and resource are the base module's; the only difference is
a `lifecycle` block on the instance that does two things:

- **`prevent_destroy = true`.** Terraform refuses any plan that would
  destroy or replace the instance, and fails with
  `Error: Instance cannot be destroyed`.
- **`ignore_changes` on the create-time attributes.** A later change to
  cloud-init `user_data`, the bootstrap SSH keys, the image, and the other
  attributes listed below plans no change, instead of a replacement. A
  change to `root_pass`, which the provider applies with a power cycle,
  plans no change either.

Use it for a server that must not be rebuilt by accident. A cloud-init
document is read at first boot only, so editing it (a timezone, a new
colleague's key) should never take a running server down, but the provider
marks it `ForceNew`, and with the base module one `yes` deletes the server.

## Usage

```hcl
module "web" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_instance_protected?ref=v2.3.0"

  label           = "web-1"
  region          = "us-east"
  type            = "g6-standard-1"
  image           = "linode/ubuntu24.04"
  authorized_keys = [var.bootstrap_ssh_key]
  metadata        = { user_data = local.cloud_init }
}
```

The inputs and outputs are the base module's; see
[`../linode_instance`](../linode_instance) for them, and for what is known
about the create-time `ipv4` argument.

## What is ignored, and why

Each attribute in the table is read once, when the instance and its boot
disk are created, and is `ForceNew` in the `linode/linode` provider
(`linode/instance/schema_resource.go`, the same in every release from v4.0.0
to v4.7.0). Changing it on a running server is never applied in place; the
provider's only answer is a replacement.

| Attribute | Why it only matters at creation |
|-----------|---------------------------------|
| `metadata` (`user_data`) | cloud-init consumes it at first boot |
| `authorized_keys` | written to root's `authorized_keys` when the disk is deployed |
| `authorized_users` | the same, from those users' Linode profile keys |
| `image` | the source of the boot disk at deploy |
| `stackscript_id`, `stackscript_data` | the StackScript runs once, at deploy |
| `backup_id` | the backup restored at creation |
| `ipv4` | the address assigned at creation; the provider reads back every IPv4 the instance holds, so an address added later would otherwise force a replacement |
| `firewall_id` | the firewall attached at creation; attach or move firewalls afterwards with `linode_firewall_device` |

`root_pass` is ignored too, for a different reason. It is not `ForceNew`:
the provider applies a change by powering the server off, resetting the
password, and booting it again. A regenerated or edited value would take the
server down on an ordinary apply. It is the **initial** root password, so
rotate it on the host. To push a new one through Terraform on purpose, use
the rebuild route below; the plain module plans it as an in-place update with
that power cycle.

So the configuration can drift from the server on these attributes, and
that is intended: the configuration describes how to build a **new** server.
Rotating keys on a running server is the configuration-management layer's
job, against the host.

Two of them need care, because ignoring them hides a change a reader might
expect a plan to show:

- **`firewall_id` shows no firewall change, ever.** A new value, or `null`
  to detach, plans nothing. The provider never reads `firewall_id` back
  either, so neither this module nor the base module has ever shown a
  firewall detached or swapped outside Terraform. To make the attachment
  visible in a plan, manage it as its own resource: `linode_firewall_device`
  (`../linode_firewall_device`) or the firewall's `linodes` list. Both read
  the attachment back from the API. Set `firewall_id` only at creation, or
  not at all.
- **`ipv4` shows no address change.** An address removed from the server
  outside Terraform plans nothing here; with the base module it plans a
  replacement, which would not bring the address back either. Watch a
  reserved address on its own resource (`../linode_reserved_ip_protected`
  and its assignment).

**Deliberately not ignored:**

- `type` and `region`: a resize or migration, done in place by the provider.
- `disk_encryption`: `ForceNew`, but ignoring it would leave the
  configuration claiming an encryption state the disk does not have. A
  change fails the plan on `prevent_destroy` instead. So does an existing
  instance whose encryption differs from the input (the default is
  `"enabled"`) when it is first moved to this module.
- Everything else the base module exposes (labels, tags, backups, alerts,
  placement group, and so on), which the provider updates in place.

"In place" is not the same as "no downtime". The provider shuts down or
reboots the server to apply a `type` resize, a `region` migration, and
`private_ip = true`, and `booted = false` powers it off. Each shows in the
plan as an ordinary `~` update.

## Switching an existing instance to this module

The resource address inside the module is `linode_instance.instance`, the
same as the base module.

- **Same module name:** change only `source` to this module, then
  `terraform init`. The state address does not change, so no `moved` block
  is needed.
- **New module name:** replace the old module call with the new one (do not
  keep both) and add a `moved` block in the consuming configuration:

  ```hcl
  moved {
    from = module.web.linode_instance.instance
    to   = module.web_protected.linode_instance.instance
  }
  ```

  For a module called with `for_each`, give the instance key on both sides
  (`module.web["a"].linode_instance.instance`).

Either way, confirm with `terraform plan` that the result has **0 to
destroy** before applying. A `user_data` that has already drifted from the
server is ignored from that plan on.

## Rebuilding on purpose

`prevent_destroy` cannot be switched off from a variable, so a deliberate
rebuild routes the instance through the base module for one apply. The
simplest way keeps the module address:

1. Change the module call's `source` from `linode_instance_protected` to
   `linode_instance` (same ref), and run `terraform init`.
2. Run `terraform plan`. Every ignored attribute that has drifted shows up
   again, with `# forces replacement`. Read it; this is the rebuild.
3. Apply it.
4. Change `source` back, `terraform init`, and confirm `terraform plan` shows
   no replacement and **0 to destroy**.

With a `moved` block instead: replace the protected call with a plain call
under a new name (keeping both fails with `Error: Moved object still
exists`), add `moved` from the protected address to the plain one, plan,
and apply. To return, **delete that first `moved` block** before adding the
reverse one; two `moved` blocks naming the same pair also fail. `terraform
state mv` of the same two addresses does the same without a block.

Between steps 1 and 4 the server has no guard. Do not leave a change
unapplied there, and do not let anything else into that apply.

These do **not** get around the guard, and are refused with
`Error: Instance cannot be destroyed`:

- `terraform apply -replace=module.web.linode_instance.instance`;
- `terraform destroy`, or `terraform plan -destroy`;
- a `for_each` routing flag flipped on an instance that already exists (the
  `allow_destroy` pattern: two module calls, one protected and one plain,
  with a variable choosing which one gets each server). Flipping it plans a
  destroy of the protected instance and fails. The flag is for a
  configuration that must be destroyable from the start, such as a test
  environment's teardown, chosen before the instance is created.

## What removes the guard

`prevent_destroy` lives in the configuration, so anything that takes this
module's resource block out of the configuration takes the guard with it.
Each of these plans a destroy, or a replacement, that nothing refuses:

- **deleting the module call;**
- **a `removed` block** for the module with `lifecycle { destroy = true }`
  (with `destroy = false` it only forgets the server, which is safe);
- **changing `source`** to the base module, or to any copy without this
  `lifecycle` block, at the same address. This is the rebuild route above,
  done by accident.

`terraform state rm` destroys nothing, but the server is then unmanaged, and
the next mistake is made by hand. Nothing in Terraform guards against a
deletion in Cloud Manager, the API, or `linode-cli`.

What a consumer can add on its own side:

- **A Linode lock** (`../linode_lock`, `lock_type = "cannot_delete"` or
  `"cannot_delete_with_subresources"`). It is enforced by Linode, so it
  refuses a deletion from every path above, Terraform included.
- **A plan gate in CI** that fails when any `linode_instance` is to be
  deleted, whatever the configuration says:

  ```sh
  terraform plan -out=tfplan
  terraform show -json tfplan | jq -e '
    [.resource_changes[]
      | select(.type == "linode_instance")
      | select(.change.actions | index("delete"))] | length == 0'
  ```

- **No `-auto-approve`** on a configuration that holds a protected server.

## Checking the guard

The plan-only tests prove the ignored attributes keep their state value
(`tests/protected.tftest.hcl`), but the mock provider does not model
`ForceNew`, so they cannot reach a replacement or `prevent_destroy`. To see
those work without touching an account, use the real provider against a
hand-written state, with `-refresh=false` so it reads no resource:

1. In a scratch directory, write a root module calling a copy of this module
   (and of the base module, for comparison), and a `terraform.tfstate`
   holding one `linode_instance` at `module.web.linode_instance.instance`
   with the attributes the configuration sets.
2. `terraform init`, then `terraform plan -refresh=false`, with
   `LINODE_TOKEN` set to a placeholder. The provider still sends one
   `GET /v4/linode/types` when it starts, to check it can reach the API.
   That endpoint is public, so the placeholder works, but the check needs
   network access.
3. Change `user_data`, then the keys, `image`, `ipv4`, `firewall_id` and
   `root_pass`, then `type`; then plan `-destroy`, and with `-replace`.
4. Change the module's `source` to the base module at the same address,
   and add a `removed` block with `destroy = true`, one at a time.

Success: the base module plans `must be replaced` for each create-time
change and an in-place update for `root_pass`; this module plans none of
them, plans the `type` change in place, and fails the destroy, the replace,
and a `disk_encryption` change with `Error: Instance cannot be destroyed`.
Step 4 plans a replacement and a destroy with no error: those are the
bypasses above. A hand-written state leaves a residual `1 to change` on
every plan, base module included, with no attribute shown; it comes from
the provider's `tags` handling, not from this module.

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_instance.instance](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The location where the Linode is deployed. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | The Linode type defines the pricing, CPU, disk, and RAM specs of the instance. | `string` | n/a | yes |
| <a name="input_alerts"></a> [alerts](#input\_alerts) | The alerts configuration for the Linode instance. | <pre>object({<br/>    cpu            = optional(number)<br/>    network_in     = optional(number)<br/>    network_out    = optional(number)<br/>    transfer_quota = optional(number)<br/>    io             = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_authorized_keys"></a> [authorized\_keys](#input\_authorized\_keys) | A list of SSH public keys to deploy for the root user. | `list(string)` | `[]` | no |
| <a name="input_authorized_users"></a> [authorized\_users](#input\_authorized\_users) | A list of Linode usernames. If the usernames have associated SSH keys, the keys will be appended to the root user's ~/.ssh/authorized\_keys file automatically. | `list(string)` | `[]` | no |
| <a name="input_backup_id"></a> [backup\_id](#input\_backup\_id) | A Backup ID from another Linode's available backups. | `string` | `null` | no |
| <a name="input_backups_enabled"></a> [backups\_enabled](#input\_backups\_enabled) | If true, the created Linode will automatically be enrolled in the Linode Backup service. | `bool` | `false` | no |
| <a name="input_booted"></a> [booted](#input\_booted) | If true, then the instance is kept or converted into a running state. | `bool` | `true` | no |
| <a name="input_disk_encryption"></a> [disk\_encryption](#input\_disk\_encryption) | The disk encryption policy for this instance. | `string` | `"enabled"` | no |
| <a name="input_firewall_id"></a> [firewall\_id](#input\_firewall\_id) | The ID of the Firewall to attach to the instance upon creation. | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | An Image ID to deploy the Disk from. | `string` | `null` | no |
| <a name="input_ipv4"></a> [ipv4](#input\_ipv4) | Reserved IPv4 addresses to assign to the Linode at creation. Null (the default) or an empty set omits the argument and Linode assigns an address as before. Changing it forces replacement; see the README. | `set(string)` | `null` | no |
| <a name="input_label"></a> [label](#input\_label) | The Linode's label for display purposes. | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | The metadata configuration for the Linode instance. | <pre>object({<br/>    user_data = string<br/>  })</pre> | `null` | no |
| <a name="input_migration_type"></a> [migration\_type](#input\_migration\_type) | The type of migration to use when updating the type or region of a Linode. | `string` | `"cold"` | no |
| <a name="input_placement_group_externally_managed"></a> [placement\_group\_externally\_managed](#input\_placement\_group\_externally\_managed) | If true, changes to the Linode's assigned Placement Group will be ignored. | `bool` | `false` | no |
| <a name="input_placement_group_id"></a> [placement\_group\_id](#input\_placement\_group\_id) | The ID of the Placement Group to assign this Linode to. | `string` | `null` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | If true, the created Linode will have private networking enabled. | `bool` | `false` | no |
| <a name="input_resize_disk"></a> [resize\_disk](#input\_resize\_disk) | If true, changes in Linode type will attempt to upsize or downsize implicitly created disks. Null (the default) omits the field so it does not trip the provider's RequiredWith(image) constraint on image-less instances. | `bool` | `null` | no |
| <a name="input_root_pass"></a> [root\_pass](#input\_root\_pass) | The initial password for the root user account. | `string` | `null` | no |
| <a name="input_shared_ipv4"></a> [shared\_ipv4](#input\_shared\_ipv4) | A set of IPv4 addresses to be shared with the Instance. | `list(string)` | `[]` | no |
| <a name="input_stackscript_data"></a> [stackscript\_data](#input\_stackscript\_data) | An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode. Null (the default) omits the field; an empty map still trips the provider's RequiredWith(image) constraint, forcing image on every instance. | `map(any)` | `null` | no |
| <a name="input_stackscript_id"></a> [stackscript\_id](#input\_stackscript\_id) | The StackScript to deploy to the newly created Linode. | `string` | `null` | no |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The swap disk size for the newly-created Linode. Null (the default) lets the provider apply its own default (512MB) when deploying from an image, and omits the field otherwise so it does not trip the provider's RequiredWith(image) constraint. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags applied to this object. | `list(string)` | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | The timeouts configuration for the Linode instance. | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_watchdog_enabled"></a> [watchdog\_enabled](#input\_watchdog\_enabled) | The watchdog, named Lassie, is a Shutdown Watchdog that monitors your Linode. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the Linode instance. |
| <a name="output_instance_ip_address"></a> [instance\_ip\_address](#output\_instance\_ip\_address) | The public IP address of the Linode instance. |
| <a name="output_instance_private_ip_address"></a> [instance\_private\_ip\_address](#output\_instance\_private\_ip\_address) | The private IP address of the Linode instance, if enabled. |
| <a name="output_instance_status"></a> [instance\_status](#output\_instance\_status) | The status of the Linode instance. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->
