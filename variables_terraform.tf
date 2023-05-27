variable "terraform" {
  description = "if cloud-init user data for installing terraform should be generated"
  type        = bool
  default     = false
}

variable "terraform_install_method" {
  description = "the install method, supported methods are 'apt'"
  type        = string
  default     = "apt"
  validation {
    condition     = contains(["apt"], var.terraform_install_method)
    error_message = "Supported values are 'apt'."
  }
}
