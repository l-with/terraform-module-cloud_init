variable "package" {
  description = "if cloud-init user data for package should be generated"
  type        = bool
  default     = true
}

variable "package_update" {
  description = "if cloud-init user data for package_update should be generated"
  type        = bool
  default     = true
}

variable "package_upgrade" {
  description = "if cloud-init user data for package_upgrade should be generated"
  type        = bool
  default     = true
}

variable "package_reboot_if_required" {
  description = "if cloud-init user data for package_reboot_if_required should be generated"
  type        = bool
  default     = false
}
