variable "fail2ban" {
  description = "if cloud-init user data for installing fail2ban should be generated"
  type        = bool
  default     = false
}

variable "fail2ban_sshd" {
  description = "if sshd jail install should be generated"
  type        = bool
  default     = true
}

variable "fail2ban_recidive" {
  description = "if recidive jail install should be generated"
  type        = bool
  default     = true
}
