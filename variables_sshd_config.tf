variable "sshd_config" {
  description = "if cloud-init user data for managing sshd config should be generated"
  type        = bool
  default     = false
}

variable "sshd_config_passwordauthentication" {
  description = "value for [`PasswordAuthentication`](https://man.openbsd.org/sshd_config#PasswordAuthentication) in /etc/sshd_config"
  type        = bool
  default     = false
}

variable "sshd_config_trusted_user_ca_keys" {
  description = "content of `/etc/ssh/trusted-user-ca-keys.pem` as value for [`TrustedUserCAKeys`](https://man.openbsd.org/sshd_config#TrustedUserCAKeys)"
  type        = string
  default     = null
}

variable "sshd_config_remove_authorized_keys" {
  description = "if the file `/root/.ssh/authorized_keys` should be deleted"
  type        = bool
  default     = false
}
