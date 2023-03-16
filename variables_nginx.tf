variable "nginx" {
  description = "if cloud-init user data for installing nginx should be generated"
  type        = bool
  default     = false
}

variable "nginx_configuration_home" {
  description = "the nginx configuration home"
  type        = string
  default     = "/etc/nginx"
}

variable "nginx_server_fqdn" {
  description = "the FQDN of the server for nginx server_name and Let's Encrypt certificates"
  type        = string
  default     = ""
}

variable "nginx_gnu" {
  description = "if the [GNU Terry Pratchett](http://www.gnuterrypratchett.com) header should be inserted"
  type        = bool
  default     = true
}

variable "nginx_https_conf" {
  description = "the nginx https configuration after `server_name`"
  type        = string
  default     = ""
}

variable "nginx_confs" {
  description = "the extra configurations for nginx"
  type = list(object({
    port        = number // the port for `listen`
    server_name = string // the server_name for `server_name`
    fqdn        = string // the FQDN used for include Let's Encrypt certificates: `/etc/letsencrypt/live/{{ nginx_conf.FQDN }}/...`
    conf        = string // the configuration to be included in the `sever` stanza
  }))
  default = []
}

variable "nginx_https_map" {
  description = "the map stanza configuration for nginx https configuration"
  type        = string
  default     = ""
}