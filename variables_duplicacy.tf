variable "duplicacy" {
  description = "if cloud-init user data for installing duplicacy should be generated"
  type        = bool
  default     = false
}

variable "duplicacy_path" {
  description = "the path to install duplicacy"
  type        = string
  default     = "/opt/duplicacy"
}

variable "duplicacy_version" {
  description = "the duplicacy version to install"
  type        = string
  default     = "3.1.0"
}
