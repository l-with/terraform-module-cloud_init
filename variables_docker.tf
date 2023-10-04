variable "docker" {
  description = "if cloud-init user data for installing docker should be generated"
  type        = bool
  default     = false
}

variable "docker_install_method" {
  description = <<EOT
  the install method, supported methods are 'apt', 'binary'
  - 'binary' uses docker_version and activates containerd installation
EOT
  type        = string
  default     = "apt"
  validation {
    condition     = contains(["apt", "binary"], var.docker_install_method)
    error_message = "Supported values are 'apt', 'binary'."
  }
}

variable "docker_version" {
  description = "the docker version to be installed"
  type        = string
  default     = null
}

variable "docker_manipulate_iptables" {
  description = "if docker manipulate ip-tables should _not_ be generated for cloud-init user data for docker"
  type        = bool
  default     = true
}