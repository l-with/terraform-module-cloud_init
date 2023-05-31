variable "network" {
  description = "if the network should be configured"
  type        = bool
  default     = false
}

variable "network_dispatcher_script_path" {
  description = "the path where network dispatcher scripts should placed"
  type        = string
  default     = "/etc/network-dispatcher"
}

variable "network_dispatcher_scripts" {
  description = "the network dispatcher scripts to be placed at network_dispatcher_script_path and executed"
  type = list(object({
    script_file_name    = string,
    script_file_content = string,
  }))
  default = []
}

variable "network_resolved_conf_path" {
  description = "the path where network resolved configurations should placed"
  type        = string
  default     = "/etc/systemd/resolved.conf.d/"
}

variable "network_resolved_confs" {
  description = <<EOT
  the resolved configuration files to be placed at network_resolved_conf_path
  the service systemd-resolved is restarted
EOT
  type = list(object({
    conf_file_name    = string,
    conf_file_content = string
  }))
  default = []
}