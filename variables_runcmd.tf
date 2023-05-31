variable "runcmd" {
  description = "if runcmd scripts should be configured"
  type        = bool
  default     = false
}

variable "runcmd_scripts" {
  description = "the runcmd scripts to be executed"
  type        = list(string)
  default     = []
}
