variable "rke2" {
  description = "if cloud-init user data for the rke2 should be generated"
  type        = bool
  default     = false
}

variable "rke2_node_1st" {
  description = "if cloud-init user data for the rke2 1st node should be generated"
  type        = bool
  default     = false
}

variable "rke2_node_other" {
  description = "if cloud-init user data for the rke2 other nodes should be generated"
  type        = bool
  default     = false
}

variable "rke2_node_cert_package_url" {
  description = "the url to get the cert-package from"
  type        = string
  default     = null
}

variable "rke2_node_cert_package_api_header" {
  description = "the header to authorize getting the cert-package"
  type        = string
  default     = null
}

variable "rke2_node_cert_package_secret" {
  description = "the secret to decrypt the cert package (`openssl enc -aes-256-cbc -pbkdf2`)"
  type        = string
  default     = null
}

variable "rke2_node_pre_shared_secret" {
  description = "the pre shared secret for `/etc/rancher/rke2/config.yaml`"
  type        = string
  default     = null
  sensitive   = true
}

variable "rke2_node_config_addendum" {
  description = "the addendum to the rke2 config after the lines 'token: ...' and optional 'server: ...'"
  type        = string
  default     = "cni: cilium"
  sensitive   = true
}

variable "rke2_node_1st_rke2_role_id" {
  description = "the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault"
  type        = string
  default     = null
  sensitive   = true
}

variable "rke2_node_1st_rke2_secret_id" {
  description = "the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault"
  type        = string
  default     = null
  sensitive   = true
}

variable "rke2_node_1st_cert_manager_crd_version" {
  description = "the version of cert-manager CRDs to be installed"
  type        = string
  default     = "1.11.0"
}

variable "rke2_node_1st_vault_addr" {
  description = "the vault address to put the `ke2.yml`  as kv into"
  type        = string
  default     = null // `var.vault_addr` (implemented in rke2.tf)
}

variable "rke2_node_1st_vault_mount" {
  description = "the vault mount used to put the `rke2.yaml` as kv into vault"
  type        = string
  default     = "gitlab"
}

variable "rke2_node_1st_vault_path" {
  description = "the vault path used to put the `rke2.yaml` as kv into vault"
  type        = string
  default     = "rancher/kubeconfig"
}

variable "rke2_node_1st_vault_field" {
  description = "the vault field used to put the `rke2.yaml` as kv into vault"
  type        = string
  default     = "rke2_yaml"
}

variable "rke2_node_other_node_1st_ip" {
  description = "the ip of the 1st node for cloud-init user data for rke2 other nodes"
  type        = string
  default     = null
}
