variable "tool" {
  description = "if cloud-init user data for installing tools should be generated"
  type        = bool
  default     = false
}

variable "tools" {
  description = <<EOT
  the list of tools that should be installed
EOT
  type = list(object({
    name      = string,
    url       = string,
    dest_path = optional(string, "/usr/local/bin"),
  }))
  default = []
}
