variable "docker_container" {
  description = "if cloud-init user data for installing docker containers should be generated"
  type        = bool
  default     = false
}

variable "docker_container_list" {
  description = "the docker containers the cloud-init user data should be generated for"
  type = list(object({
    name           = string // --name
    image          = string
    ports          = string // --publish
    command        = string
    restart_policy = optional(string, "always") // --restart
  }))
  default   = []
  sensitive = true
}