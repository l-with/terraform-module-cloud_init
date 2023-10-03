variable "terraform" {
  description = "if cloud-init user data for installing terraform should be generated"
  type        = bool
  default     = false
}

variable "terraform_install_method" {
  description = <<EOT
  the install method, supported methods are 'apt', 'binary'
  - 'binary' uses terraform_version
EOT
  type        = string
  default     = "apt"
  validation {
    condition     = contains(["apt", "binary"], var.terraform_install_method)
    error_message = "Supported values are 'apt', 'binary'."
  }
}

variable "terraform_version" {
  description = "the terraform version to be installed"
  type        = string
  default     = null
}
