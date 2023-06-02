variable "jq" {
  description = "if cloud-init user data for installing jq should be generated"
  type        = bool
  default     = false
}

variable "jq_install_method" {
  description = <<EOT
  the install method, supported methods are 'binary', 'packages'
  - 'binary' uses jq_version
  - 'packages' implies that jq can not be used for configuring inside cloud-init
EOT
  type        = string
  default     = "binary"
  validation {
    condition     = contains(["binary", "packages"], var.jq_install_method)
    error_message = "Supported values are 'binary', 'packages'."
  }
}

variable "jq_version" {
  description = "the jq version to be installed"
  type        = string
  default     = "1.6"
}
