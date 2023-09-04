variable "vault_addr" {
  description = "the vault address (can be used as default for other features)"
  type        = string
  default     = null
}

variable "gzip" {
  description = "if the cloud-init user data should be packed with gzip"
  type        = bool
  default     = false
}

variable "base64_encode" {
  description = "if the cloud-init user data should be base64 encoded"
  type        = bool
  default     = false
}
