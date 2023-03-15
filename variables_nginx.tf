variable "nginx" {
  description = "if cloud-init user data for installing nginx should be generated"
  type        = bool
  default     = false
}

variable "nginx_configuration_home" {
  description = "the nginx configuration home for cloud-init user data for nginx"
  type        = string
  default     = "/etc/nginx"
}

variable "nginx_server_fqdn" {
  description = "the FQDN of the server for nginx server_name and Let's Encrypt certificates for cloud-init user data for nginx"
  type        = string
}

variable "nginx_gnu" {
  description = "if the [GNU Terry Pratchett](http://www.gnuterrypratchett.com) header should be inserted for cloud-init user data for nginx"
  type        = bool
  default     = true
}

variable "nginx_https_conf" {
  description = "the nginx https configuration after `server_name` for cloud-init user data for nginx"
  type        = string
}

variable "nginx_confs" {
  description = "the extra configurations for nginx for cloud-init user data for nginx"
  type = list(object({
    port        = number // the port for `listen`
    server_name = string // the server_name for `server_name`
    fqdn        = string // the FQDN used for include Let's Encrypt certificates: `/etc/letsencrypt/live/{{ nginx_conf.FQDN }}/...`
    nginx_conf  = string // the configuration to be included in the `sever` stanza
  }))
  default = []
}