variable "lnxrouter" {
  description = "if cloud-init user data for installing lnxrouter should be generated"
  type        = bool
  default     = false
}

variable "lnxrouter_start" {
  description = "if lnxrouter should be started"
  type        = bool
  default     = false
}

variable "lnxrouter_arguments" {
  description = <<EOT
    - ip_address: specifies the interface ($interface in arguments)
    - arguments: specifies the command line arguments to start lnxrouter with, $interface will be substituted by the name of the interface bound to the ip_address (`ifconfig | grep --before-context=1 10.0.0.20 | grep --only-matching "^\w*"`)
EOT
  type = object({
    ip_address = optional(string, null)
    arguments  = string
  })
  default = null
}
