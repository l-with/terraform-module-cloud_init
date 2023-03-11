variable "docker" {
  description = "if cloud-init user data for installing docker should be generated"
  type        = bool
  default     = false
}

variable "docker_vars" {
  description = "the variables for cloud-init user data for docker"
  type = object({
    docker_manipulate_iptables = bool
  })
  default = {
    docker_manipulate_iptables = true
  }
}