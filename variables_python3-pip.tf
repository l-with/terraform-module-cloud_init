variable "python3_pip" {
  description = "if cloud-init user data for installing python3-pip should be generated"
  type        = bool
  default     = false
}

variable "python3_pip_modules" {
  description = "the python modules to be installed"
  type        = list(string)
  default     = []
}