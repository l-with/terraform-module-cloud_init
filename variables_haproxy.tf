variable "haproxy" {
  description = "if cloud-init user data for installing haproxy should be generated"
  type        = bool
  default     = false
}

variable "haproxy_configuration" {
  description = "the configuration for haproxy"
  type        = string
  default     = null
}