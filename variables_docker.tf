variable "docker" {
  description = "if cloud-init user data for installing docker should be generated"
  type        = bool
  default     = false
}

variable "docker_manipulate_iptables" {
  description = "if docker manipulate ip-tables should _not_ be generated for cloud-init user data for docker"
  type        = bool
  default     = true
}