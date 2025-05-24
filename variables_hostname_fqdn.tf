variable "hostname_fqdn" {
  description = "if cloud-init user data for hostname and FQDN should be generated"
  type        = bool
  default     = false
}

variable "hostname" {
  description = "the hostname"
  type        = string
  default     = null
}

variable "fqdn" {
  description = "the FQDN"
  type        = string
  default     = null
}
