variable "vault" {
  description = "if cloud-init user data for installing vault should be generated"
  type        = bool
  default     = false
}

variable "vault_install_method" {
  description = <<EOT
  the install method, supported methods are 'apt', 'binary'
  - 'binary' uses vault_version
EOT
  type        = string
  default     = "apt"
  validation {
    condition     = contains(["apt", "binary"], var.vault_install_method)
    error_message = "Supported values are 'apt', 'binary'."
  }
}

variable "vault_version" {
  description = "the vault version to be installed"
  type        = string
  default     = null
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

variable "vault_api_addr" {
  description = <<EOT
    the [api_addr](https://www.vaultproject.io/docs/configuration#api_addr)
    the string '$ipv4_address' can be used as placeholder for the server ipv4-address
  EOT
  type        = string
  default     = null
}

variable "vault_cluster_addr" {
  description = <<EOT
    the [cluster_addr](https://www.vaultproject.io/docs/configuration#cluster_addr)
    the string '$ipv4_address' can be used as placeholder for the server ipv4-address (determined by variable ipv4_address_command)
  EOT
  type        = string
  default     = null
}

variable "vault_listeners" {
  description = <<EOT
    the list of [listener](https://www.vaultproject.io/docs/configuration/listener/tcp)s
    the default for each (coded in terraform)
      - tls_cert_file is [vault_tls_cert_file](#input_vault_tls_cert_file)
      - tls_key_file is [vault_tls_key_file](#input_vault_tls_key_file)
      - tls_client_ca_file [vault_tls_client_ca_file](#input_vault_tls_client_ca_file)
    the string '$ipv4_address' can be used as placeholder for the server ipv4-address in address and cluster_adrress
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

variable "vault_init" {
  description = "if vault should be initialized"
  type        = bool
  default     = true
}

variable "vault_key_shares" {
  description = "the number of [key shares](https://developer.hashicorp.com/vault/docs/commands/operator/init#key-shares)"
  type        = number
  default     = 1
}

variable "vault_key_threshold" {
  description = "the number of key shares required to reconstruct the root key (s. https://developer.hashicorp.com/vault/docs/commands/operator/init#key-threshold)"
  type        = number
  default     = 1
}

variable "vault_init_pgp_public_keys" {
  description = <<EOT
    the definition of the usage of pgp keys for vault init
    note: the number of pgp_external_public_keys plus num_internal_unseal_keys has to match vault_key_shares
  EOT
  type = object({
    num_internal_unseal_keys = optional(number, 1),
    pgp_external_public_keys = optional(list(object({
      content  = string,
      encoding = optional(string, "text/plain"),
      owner    = optional(string, "root")
      group    = optional(string, "root")
      mode     = optional(string, "640")
    })), [])
  })
  default = null
}

variable "vault_revoke_root_token" {
  description = "if the initial root token should be revoked"
  type        = bool
  default     = true
}

variable "vault_local_addr" {
  description = "the vault address used for vault init, vault operator init, vault operator unseal and vault token revoke during cloud init"
  type        = string
  default     = null
}

variable "vault_unseal" {
  description = "if vault should be unsealed"
  type        = bool
  default     = false
}

variable "vault_bootstrap_files_path" {
  description = "the path where the files needed for bootstrapping are saved"
  type        = string
  default     = "/root"
}

variable "vault_init_public_key" {
  description = "the public RSA key the output of the vault initialization is encoded with (to be decryptable by the corresponding private key with [rsadecrypt](https://developer.hashicorp.com/terraform/language/functions/rsadecrypt)"
  type        = string
  default     = null
}

variable "vault_spread_vault_init_json" {
  description = "if the vault init json result should be spread to the cluster"
  type        = bool
  default     = false
}

variable "vault_spread_vault_init_json_id_file" {
  description = "the ssh id file used for spreading the vault init json result to the cluster"
  type        = string
  default     = null
}

variable "vault_remove_spread_vault_init_json_id_file" {
  description = "if the ssh id file used for spreading the vault init json result to the cluster should be removed after used"
  type        = bool
  default     = true
}

variable "vault_fetch_vault_init_json_id_file" {
  description = "the ssh id file used for fetching the vault init json result"
  type        = string
  default     = null
}

variable "vault_remove_fetch_vault_init_json_id_file" {
  description = "if the ssh id file used for fetching the vault init json result should be removed after used"
  type        = bool
  default     = true
}

variable "vault_receive_vault_init_json" {
  description = "if the vault init json result should be received"
  type        = bool
  default     = false
}

variable "vault_fetch_vault_init_json_from" {
  description = "the node the vault init json result should be fetched from"
  type        = string
  default     = false
}

variable "vault_remove_vault_init_json" {
  description = <<EOT
    if the output of the vault initialization should removed
    <span style=\"color:red\">ATTENTION: The output of the vault initialization is highly confidential! It is the root of the secret management in vault!</span>"
  EOT
  type        = bool
  default     = true
}

variable "vault_init_json_file_mode" {
  description = "the file mode for the vault init json result files"
  type        = string
  default     = "640"
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

variable "vault_tls_storage_raft_leader_ca_cert_file" {
  description = <<EOT
    the [leader_ca_cert_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_ca_cert_file)
    default is [vault_home_path](#input_vault_home_path)/tls/client_ca.pem (coded in terraform)
  EOT
  type        = string
  default     = null
}

variable "vault_tls_storage_raft_leader_client_cert_file" {
  description = <<EOT
    the [leader_client_cert_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_client_cert_file)
    default is [vault_home_path](#input_vault_home_path)/tls/cert.pem (coded in terraform)
  EOT
  type        = string
  default     = null
}

variable "vault_tls_storage_raft_leader_client_key_file" {
  description = <<EOT
    the [leader_client_key_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_client_key_file)
    default is [vault_home_path](#input_vault_home_path)/tls/key.pem (coded in terraform)
  EOT
  type        = string
  default     = null
}

variable "vault_raft_retry_autojoin" {
  description = <<EOT
    the auto_join values for [retry_join](https://developer.hashicorp.com/vault/docs/configuration/storage/raft#retry_join-stanza)
    - [auto_join](https://developer.hashicorp.com/vault/docs/configuration/storage/raft#auto_join)
    - [auto_join_scheme](https://developer.hashicorp.com/vault/docs/configuration/storage/raft#auto_join_scheme)
    - [auto_join_port](https://developer.hashicorp.com/vault/docs/configuration/storage/raft#auto_join_port)
  EOT
  type = object({
    auto_join        = string,
    auto_join_scheme = optional(string, null),
    auto_join_port   = optional(number, null),
  })
  default = null
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

variable "vault_tls_files" {
  description = <<EOT
    DEPRECATED: use vault_tls_contents instead
    the vault tls files
    filename can contain the placeholders
      - $vault_tls_cert_file
      - $vault_tls_key_file
      - $vault_tls_client_ca_file
    which are replace by the corresponding terraform variables
  - encoding of the content can be 'text/plain' (default) or 'base64'
EOT
  type = list(object({
    file_name = string,
    content   = string,
    encoding  = optional(string, "text/plain")
    owner     = optional(string, "vault")
    group     = optional(string, "vault")
    mode      = optional(string, "640")
  }))
  default = []
}

variable "vault_tls_contents" {
  description = <<EOT
    the vault tls file contents
    tls_file has to be one of
      - cert
      - key
      - client_ca
      - storage_raft_leader_ca_cert
      - storage_raft_leader_client_cert
      - storage_raft_leader_client_key
    and the corresponding terraform variable is used as file_name
  - encoding of the content can be 'text/plain' (default) or 'base64'
EOT
  type = list(object({
    tls_file = optional(string, null),
    content  = string,
    encoding = optional(string, "text/plain")
    owner    = optional(string, "vault")
    group    = optional(string, "vault")
    mode     = optional(string, "640")
  }))
  default = []
  validation {
    condition = !contains(
      [
        for tls_content in var.vault_tls_contents :
        contains(
          [
            "cert",
            "key",
            "client_ca",
            "storage_raft_leader_ca_cert",
            "storage_raft_leader_client_cert",
            "storage_raft_leader_client_key"
          ],
          tls_content.tls_file
        )
      ],
      false
    )
    error_message = "Supported values are cert, key, client_ca, storage_raft_leader_ca_cert, storage_raft_leader_client_cert, storage_raft_leader_client_key."
  }
}

variable "vault_chown_files" {
  description = "the list of files to be changed to ownership vault:vault (before starting vault)"
  type        = list(string)
  default     = []
}
