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
  description = <<EOT
    the network dispatcher scripts to be placed at network_dispatcher_script_path and executed
    the string '$public_interface' can be used as placeholder for the device for internet access
    (ip route get 8.8.8.8 | grep 8.8.8.8 | cut -d ' ' -f 5)
EOT
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