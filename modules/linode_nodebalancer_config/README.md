# Linode NodeBalancer Config Terraform Module

This module manages a single `linode_nodebalancer_config` — one port
configuration on an existing NodeBalancer, defining its protocol, routing
algorithm, session stickiness, TLS, and backend health checks. The
NodeBalancer itself is managed separately; supply its ID via
`nodebalancer_id`.

## Usage

```hcl
module "nodebalancer_config" {
  source = "github.com/harleypig/linode-foundation-fabric//modules/linode_nodebalancer_config?ref=v0.2.0"

  nodebalancer_id = 12345

  port      = 80
  protocol  = "http"
  algorithm = "roundrobin"

  check          = "http"
  check_path     = "/"
  check_interval = 30
  check_timeout  = 5
  check_attempts = 3
}
```

<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_linode"></a> [linode](#requirement\_linode) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_linode"></a> [linode](#provider\_linode) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [linode_nodebalancer_config.this](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/nodebalancer_config) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nodebalancer_id"></a> [nodebalancer\_id](#input\_nodebalancer\_id) | The ID of the NodeBalancer to access. | `number` | n/a | yes |
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | What algorithm this NodeBalancer should use for routing traffic to backends: roundrobin, leastconn, source. | `string` | `null` | no |
| <a name="input_check"></a> [check](#input\_check) | The type of check to perform against backends to ensure they are serving requests. This is used to determine if backends are up or down. If none no check is performed. connection requires only a connection to the backend to succeed. http and http\_body rely on the backend serving HTTP, and that the response returned matches what is expected. | `string` | `null` | no |
| <a name="input_check_attempts"></a> [check\_attempts](#input\_check\_attempts) | How many times to attempt a check before considering a backend to be down. (1-30) | `number` | `null` | no |
| <a name="input_check_body"></a> [check\_body](#input\_check\_body) | This value must be present in the response body of the check in order for it to pass. If this value is not present in the response body of a check request, the backend is considered to be down. | `string` | `null` | no |
| <a name="input_check_interval"></a> [check\_interval](#input\_check\_interval) | How often, in seconds, to check that backends are up and serving requests. | `number` | `null` | no |
| <a name="input_check_passive"></a> [check\_passive](#input\_check\_passive) | If true, any response from this backend with a 5xx status code will be enough for it to be considered unhealthy and taken out of rotation. | `bool` | `null` | no |
| <a name="input_check_path"></a> [check\_path](#input\_check\_path) | The URL path to check on each backend. If the backend does not respond to this request it is considered to be down. | `string` | `null` | no |
| <a name="input_check_timeout"></a> [check\_timeout](#input\_check\_timeout) | How long, in seconds, to wait for a check attempt before considering it failed. (1-30) | `number` | `null` | no |
| <a name="input_cipher_suite"></a> [cipher\_suite](#input\_cipher\_suite) | What ciphers to use for SSL connections served by this NodeBalancer. `legacy` is considered insecure and should only be used if necessary. | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | The TCP port this Config is for. These values must be unique across configs on a single NodeBalancer (you can't have two configs for port 80, for example). While some ports imply some protocols, no enforcement is done and you may configure your NodeBalancer however is useful to you. For example, while port 443 is generally used for HTTPS, you do not need SSL configured to have a NodeBalancer listening on port 443. | `number` | `null` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol this port is configured to serve. If this is set to https you must include an ssl\_cert and an ssl\_key. | `string` | `null` | no |
| <a name="input_proxy_protocol"></a> [proxy\_protocol](#input\_proxy\_protocol) | The version of ProxyProtocol to use for the underlying NodeBalancer. This requires protocol to be `tcp`. Valid values are `none`, `v1`, and `v2`. | `string` | `null` | no |
| <a name="input_ssl_cert"></a> [ssl\_cert](#input\_ssl\_cert) | The certificate this port is serving. This is not returned. If set, this field will come back as `<REDACTED>`. Please use the ssl\_commonname and ssl\_fingerprint to identify the certificate. | `string` | `null` | no |
| <a name="input_ssl_key"></a> [ssl\_key](#input\_ssl\_key) | The private key corresponding to this port's certificate. This is not returned. If set, this field will come back as `<REDACTED>`. Please use the ssl\_commonname and ssl\_fingerprint to identify the certificate. | `string` | `null` | no |
| <a name="input_stickiness"></a> [stickiness](#input\_stickiness) | Controls how session stickiness is handled on this port: 'none', 'table', 'http\_cookie'. | `string` | `null` | no |
| <a name="input_udp_check_port"></a> [udp\_check\_port](#input\_udp\_check\_port) | Specifies the port on the backend node used for active health checks, which may differ from the port serving traffic. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Linode NodeBalancer Config. |
| <a name="output_node_status"></a> [node\_status](#output\_node\_status) | A structure containing information about the health of the backends for this port, updated periodically as checks are performed. |
| <a name="output_nodebalancer_id"></a> [nodebalancer\_id](#output\_nodebalancer\_id) | The ID of the NodeBalancer this Config belongs to. |
| <a name="output_port"></a> [port](#output\_port) | The TCP port this Config is for. |
| <a name="output_protocol"></a> [protocol](#output\_protocol) | The protocol this port is configured to serve. |
| <a name="output_ssl_commonname"></a> [ssl\_commonname](#output\_ssl\_commonname) | The read-only common name automatically derived from the SSL certificate assigned to this NodeBalancerConfig. |
| <a name="output_ssl_fingerprint"></a> [ssl\_fingerprint](#output\_ssl\_fingerprint) | The read-only fingerprint automatically derived from the SSL certificate assigned to this NodeBalancerConfig. |
| <a name="output_udp_session_timeout"></a> [udp\_session\_timeout](#output\_udp\_session\_timeout) | The read-only idle time in seconds after which a session that hasn't received packets is destroyed. |
<!-- markdownlint-restore -->
<!-- END_TF_DOCS -->

## Notes

- When `protocol` is `https`, the Linode API requires both `ssl_cert` and
  `ssl_key`; the module passes them through but does not enforce the pairing.
- `ssl_cert` / `ssl_key` are write-only: the API returns them as `<REDACTED>`.
  Identify the assigned certificate via the read-only `ssl_commonname` /
  `ssl_fingerprint` outputs instead.
- `proxy_protocol` requires `protocol = "tcp"`.
- Most optional inputs default to `null`, letting the provider apply its own
  defaults (for example, `algorithm`, `protocol`, and the `check_*` fields).
- The backing NodeBalancer must already exist; this module only adds a port
  config to it.
