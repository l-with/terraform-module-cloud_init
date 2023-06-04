variable "certbot" {
  description = "if cloud-init user data for installing certbot should be generated"
  type        = bool
  default     = false
}

variable "certbot_dns_hetzner" {
  description = "if cloud-init user data for installing with certbot-dns-hetzner should be generated"
  type        = bool
  default     = false
}

variable "certbot_automatic_renewal_cron" {
  description = "the cron schedule expression for certbot renewal"
  type        = string
  default     = "0 0,12 * * *"
}

variable "certbot_automatic_renewal_cronjob" {
  description = "the cron job for certbot renewal"
  type        = string
  default     = "python3 -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q"
}

variable "certbot_automatic_renewal_post_hooks" {
  description = "the certbot automatic renewal post hook scripts"
  type = list(object({
    file_name = string
    content   = string
  }))
  default = []
}
