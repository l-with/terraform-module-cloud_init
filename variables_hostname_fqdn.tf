variable "hostname_fqdn" {
  description = "if cloud-init user data for hostname and FQDN should be generated"
  type        = bool
  default     = false
}

variable "hostname" {
  description = "the value for 'hostname'"
  type        = string
  default     = null
}

variable "fqdn" {
  description = "the value for 'fqdn'"
  type        = string
  default     = null
}


variable "create_hostname_file" {
  description = "the value for 'create_hostname_file'"
  type        = bool
  default     = null
}

variable "prefer_fqdn_over_hostname" {
  description = "the value for 'prefer_fqdn_over_hostname'"
  type        = bool
  default     = null
}