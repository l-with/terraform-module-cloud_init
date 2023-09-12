variable "vault_addr" {
  description = "the vault address (can be used as default for other features)"
  type        = string
  default     = null
}

variable "gzip" {
  description = "if the cloud-init user data should be packed with gzip"
  type        = bool
  default     = false
}

variable "base64_encode" {
  description = "if the cloud-init user data should be base64 encoded"
  type        = bool
  default     = false
}

variable "ipv4_address_command" {
  description = <<EOT
    the command to determin the ipv4 address, other possible ways are
      - ip route get 8.8.8.8 | grep 8.8.8.8 | sed -E 's/.*src (\S*) .*/\1/'
      - ip addr show | grep 'inet ' | grep 'scope global' | cut -d ' ' -f6 | cut -d '/' -f 1 | head -n 1
      - curl https://ifconfig.me
  EOT
  type        = string
  default     = "ip addr show | grep 'inet ' | grep 'scope global' | cut -d ' ' -f6 | cut -d '/' -f 1 | head -n 1"
}

variable "ip_addresses" {
  description = "the list of ip address suffixes and the commands to compute them (s. variable ip4_address_command)"
  type = list(object({
    ip_address_suffix   = string
    computation_command = string
  }))
  default = []
}
