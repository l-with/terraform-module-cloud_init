variable "hetzner" {
  description = "if cloud-init user data for making changes on a Hetzner Cloud Server should be generated"
  type        = bool
  default     = false
}

variable "hetzner_remove_fqdn_resolve" {
  description = "if the FQDN should be removed from the entry `127.0.1.1 ...` in `/etc/hosts`"
  type        = bool
  default     = true
}

