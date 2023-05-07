variable "vault" {
  description = "if cloud-init user data for installing vault should be generated"
  type        = bool
  default     = false
}

variable "vault_start" {
  description = "if vault should be started "
  type        = bool
  default     = false
}

variable "vault_home_path" {
  description = "the home of the vault specific files and folders"
  type        = string
  default     = "/srv/vault"
}

variable "vault_config_path" {
  description = "the path for the vault configuration files"
  type        = string
  default     = "/etc/vault.d"
}

variable "vault_ui" {
  description = "if the vault user interface should be activated"
  type        = bool
  default     = false
}

variable "vault_log_level" {
  description = "the [vault log level](https://www.vaultproject.io/docs/configuration#log_level)"
  type        = string
  default     = "info"
  validation {
    condition     = contains(["trace", "debug", "info", "warn", "error"], var.vault_log_level)
    error_message = "Supported values (in order of descending detail) are trace, debug, info, warn, and error."
  }
}

variable "vault_api_port" {
  description = "the vault api port (for [api_addr](https://www.vaultproject.io/docs/configuration#api_addr) and [address](https://www.vaultproject.io/docs/configuration/listener/tcp#address))"
  type        = number
  default     = 8200
}

variable "vault_api_addr" {
  description = "the [api_addr](https://www.vaultproject.io/docs/configuration#api_addr)"
  type        = string
  default     = "http://127.0.0.1:8200"
}

variable "vault_cluster_port" {
  description = "the vault cluster port (for [cluster_addr](https://www.vaultproject.io/docs/configuration#cluster_addr) and [cluster_address](https://www.vaultproject.io/docs/configuration/listener/tcp#cluster_address))"
  type        = number
  default     = 8201
}

variable "vault_cluster_addr" {
  description = "the [cluster_addr](https://www.vaultproject.io/docs/configuration#cluster_addr)"
  type        = string
  default     = "http://127.0.0.1:8201"
}

variable "vault_listeners" {
  description = <<EOT
    the list of [listener](https://www.vaultproject.io/docs/configuration/listener/tcp)s
    the default for each (coded in terraform)
      - tls_cert_file is [vault_tls_cert_file](#input_vault_tls_cert_file)
      - tls_key_file is [vault_tls_key_file](#input_vault_tls_key_file)
      - tls_client_ca_file [vault_tls_client_ca_file](#input_vault_tls_client_ca_file)
  EOT
  type = list(object({
    address            = string,
    cluster_address    = optional(string, null),
    tls_disable        = optional(bool, true),
    tls_cert_file      = optional(string, null),
    tls_key_file       = optional(string, null),
    tls_client_ca_file = optional(string, null),
  }))
  default = []
}

variable "vault_disable_mlock" {
  description = "the value for [disable_mlock](https://www.vaultproject.io/docs/configuration#disable_mlock)"
  type        = bool
  default     = true
}

variable "vault_storage_raft_path" {
  description = "the `path` value for `storage \"raft\"`"
  type        = string
  default     = "/srv/vault/file/raft"
}

variable "vault_storage_raft_node_id" {
  description = "the `node_id` value for `storage \"raft\"`"
  type        = string
  default     = null
}

variable "vault_storage_raft_cluster_members" {
  description = "the list of cluster members for the [retry_join-stanza](https://www.vaultproject.io/docs/configuration/storage/raft#retry_join-stanza)s"
  type        = list(string)
  default     = []
}

variable "vault_storage_raft_cluster_member_this" {
  description = "the actual instance to be excluded for the [retry_join-stanza](https://www.vaultproject.io/docs/configuration/storage/raft#retry_join-stanza)s"
  type        = string
  default     = null
}

variable "vault_storage_raft_retry_join_api_port" {
  description = "the port number for the [leader_api_addr](https://developer.hashicorp.com/vault/docs/configuration/storage/raft#leader_api_addr) in the [retry_join-stanza](https://www.vaultproject.io/docs/configuration/storage/raft#retry_join-stanza)s"
  type        = number
  default     = 8200
}

variable "vault_storage_raft_leader_ca_cert_file" {
  description = "the [leader_ca_cert_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_ca_cert_file)"
  type        = string
  default     = null
}

variable "vault_storage_raft_leader_client_cert_file" {
  description = "the [leader_client_cert_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_client_cert_file)"
  type        = string
  default     = null
}

variable "vault_storage_raft_leader_client_key_file" {
  description = "the [leader_client_key_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_client_key_file)"
  type        = string
  default     = null
}

variable "vault_raft_leader_tls_servername" {
  description = "the [leader_tls_servername](https://www.vaultproject.io/docs/configuration/storage/raft#leader_tls_servername)"
  type        = string
  default     = null
}

variable "vault_tls_cert_file" {
  description = <<EOT
    the path of the certificate for TLS ([tls_cert_file](https://www.vaultproject.io/docs/configuration/listener/tcp#tls_cert_file)
    default is [vault_storage_raft_leader_client_cert_file](#input_vault_storage_raft_leader_client_cert_file) (coded in terraform)
  EOT
  type        = string
  default     = null
}

variable "vault_tls_key_file" {
  description = <<EOT
    the path of the private key for the certificate for TLS ([tls_key_file](https://www.vaultproject.io/docs/configuration/listener/tcp#tls_key_file))
    default is [vault_storage_raft_leader_client_key_file](#input_vault_storage_raft_leader_client_key_file) (coded in terraform)
  EOT
  type        = string
  default     = null
}

variable "vault_tls_client_ca_file" {
  description = <<EOT
    the [tls_client_ca_file](https://www.vaultproject.io/docs/configuration/listener/tcp#tls_client_ca_file)
    default is [vault_storage_raft_leader_ca_cert_file](#input_vault_storage_raft_leader_ca_cert_file) (coded in terraform)
  EOT
  type        = string
  default     = null
}
