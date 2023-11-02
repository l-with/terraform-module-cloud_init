variable "unzip" {
  description = "if cloud-init user data for installing unzip should be generated"
  type        = bool
  default     = false
}

variable "unzip_install_method" {
  description = <<EOT
  the install method, supported methods are 'apt', 'zypper'
EOT
  type        = string
  default     = "apt"
  validation {
    condition     = contains(["apt", "zypper"], var.unzip_install_method)
    error_message = "Supported values are 'apt', 'zypper'."
  }
}
