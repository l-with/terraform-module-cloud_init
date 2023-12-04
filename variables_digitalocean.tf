variable "digitalocean" {
  description = "if cloud-init user data for making changes on a Digitalocean Droplet should be generated"
  type        = bool
  default     = false
}

variable "digitalocean_restart_journald" {
  description = "if the journald should be restarted (fixes missing logs)"
  type        = bool
  default     = true
}

