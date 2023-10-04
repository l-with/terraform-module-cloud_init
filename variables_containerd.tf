variable "containerd" {
  description = "if cloud-init user data for installing containerd should be generated"
  type        = bool
  default     = false
}

variable "containerd_install_method" {
  description = <<EOT
  the install method, supported methods are 'binary'
  - 'binary' uses containerd_version
EOT
  type        = string
  default     = "binary"
  validation {
    condition     = contains(["binary"], var.containerd_install_method)
    error_message = "Supported values are 'binary'."
  }
}

variable "containerd_version" {
  description = "the containerd version to be installed"
  type        = string
  default     = null
}
