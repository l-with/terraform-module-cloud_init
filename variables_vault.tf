variable "vault" {
  description = "if cloud-init user data for installing vault should be generated"
  type        = bool
  default     = false
}

variable "vault_version" {
  description = "the vault version that should be used to install"
  type        = string
  default     = "1.13.0"
}