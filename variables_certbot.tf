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
