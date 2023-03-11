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

variable "fail2ban_vars" {
  description = "the variables for cloud-init user data for rke2 1st and other masters"
  type = object({
    rke2_cert_package_url       = string
    rke2_cert_artifact          = string
    rke2_cert_package_api_token = string
    rke2_cert_package_secret    = string
    rke2_pre_shared_secret      = string
  })
  default = {
    rke2_cert_package_url       = ""
    rke2_cert_artifact          = ""
    rke2_cert_package_api_token = ""
    rke2_cert_package_secret    = ""
    rke2_pre_shared_secret      = ""
  }
}