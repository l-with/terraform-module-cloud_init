variable "jq" {
  description = "if cloud-init user data for installing jq should be generated"
  type        = bool
  default     = false
}

variable "jq_version" {
  description = "the jq version to be installed"
  type        = string
  default     = "1.6"
}
