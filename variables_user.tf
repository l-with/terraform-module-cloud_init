variable "user" {
  description = "if cloud-init user data for users should be generated"
  type        = bool
  default     = true
}

variable "users" {
  description = "the list of user configurations"
  type = list(object({
    name                = string,
    groups              = optional(string, null),
    sudo                = optional(string, null),
    ssh_authorized_keys = optional(list(string), []),
    lock_passwd         = optional(bool, true),
  }))
  default = []
}
