variable "certbot" {
  description = "if cloud-init user data for installing certbot should be generated"
  type        = bool
  default     = false
}

variable "certbot_dns_plugins" {
  description = "the list of certbot plugins to be installed"
  type        = list(string)
  default     = []
}

variable "certbot_automatic_renewal_cron" {
  description = "the cron schedule expression for certbot renewal"
  type        = string
  default     = "0 */12 * * *"
}

variable "certbot_automatic_renewal_cronjob" {
  description = "the cron job for certbot renewal"
  type        = string
  default     = "test -x /usr/bin/certbot -a \\! -d /run/systemd/system && perl -e 'sleep int(rand(43200))' && certbot -q renew"
}

variable "certbot_automatic_renewal_post_hooks" {
  description = "the certbot automatic renewal post hook scripts"
  type = list(object({
    file_name = string
    content   = string
  }))
  default = []
}
