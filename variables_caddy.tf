variable "caddy" {
  description = "if cloud-init user data for installing caddy should be generated"
  type        = bool
  default     = false
}

variable "caddy_configuration" {
  description = "the caddy configuration"
  type        = string
  default     = null
}
