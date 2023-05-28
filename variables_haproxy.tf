variable "haproxy" {
  description = "if cloud-init user data for installing haproxy should be generated"
  type        = bool
  default     = false
}

variable "haproxy_configuration" {
  description = "the configuration for [haproxy](https://www.haproxy.com/documentation/hapee/latest/configuration/config-sections/overview/#haproxy-enterprise-configuration-sections)"
  type = object({
    global = optional(
      string,
      <<EOT
	log /dev/log	local0
	log /dev/log	local1 notice
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
    ),
    defaults = optional(list(string), []),
    listen   = optional(list(string), []),
    frontend = optional(list(string), []),
    backend  = optional(list(string), []),
    peers    = optional(list(string), []),
  })
  default = {
    global   = null,
    defaults = [],
    listen   = [],
    frontend = [],
    backend  = [],
    peers    = [],
  }
}