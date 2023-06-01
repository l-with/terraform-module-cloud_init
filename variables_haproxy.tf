variable "haproxy" {
  description = "if cloud-init user data for installing haproxy should be generated"
  type        = bool
  default     = false
}

variable "haproxy_configuration" {
  description = <<EOT
    the configuration for [haproxy](https://www.haproxy.com/documentation/hapee/latest/configuration/config-sections/overview/#haproxy-enterprise-configuration-sections)
    the string '$ipv4_public_address' can be used as placeholder for the public ipv4-address of the server
    (ip route get 8.8.8.8 | grep 8.8.8.8 | cut -d ' ' -f 7)

EOT
  type = object({
    global = optional(
      object({
        configuration = string
      }),
      {
        configuration = <<EOT
  log /dev/log local0
  log /dev/log local1 notice
  chroot /var/lib/haproxy
  stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
  stats timeout 30s
  user haproxy
  group haproxy
  daemon

  # Default SSL material locations
  ca-base /etc/ssl/certs
  crt-base /etc/ssl/private

  # See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
  ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
  ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
  ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets
EOT
      }
    )
    frontend = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    backend = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    defaults = optional(
      list(object({
        configuration = string,
        })
      ),
      [
        {
          configuration = <<EOT
  log global
  mode http
  option httplog
  option dontlognull
  timeout connect 5000
  timeout client 50000
  timeout server 50000
  errorfile 400 /etc/haproxy/errors/400.http
  errorfile 403 /etc/haproxy/errors/403.http
  errorfile 408 /etc/haproxy/errors/408.http
  errorfile 500 /etc/haproxy/errors/500.http
  errorfile 502 /etc/haproxy/errors/502.http
  errorfile 503 /etc/haproxy/errors/503.http
  errorfile 504 /etc/haproxy/errors/504.http
EOT
      }]
    ),
    listen = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    aggregations = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    cache = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    dynamic-update = optional(list(string), []),
    fcgi-app = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    http-errors = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    mailers = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    peers = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    program = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    resolvers = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    ring = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
    userlist = optional(
      list(object({
        label         = string,
        configuration = string,
      })),
      []
    ),
  })
  default = null
}
