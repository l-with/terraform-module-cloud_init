variable "rke2_node_1st" {
  description = "if cloud-init user data for the rke2 1st masters should be generated"
  type        = bool
  default     = false
}

variable "rke2_node_other" {
  description = "if cloud-init user data for the rke2 other masters should be generated"
  type        = bool
  default     = false
}

variable "rke2_node_vars" {
  description = "the variables for cloud-init user data for rke2 1st and other masters"
  type = object({
    rke2_cert_package_url        = string
    rke2_cert_package_api_header = string
    rke2_cert_package_secret     = string
    rke2_pre_shared_secret       = string
  })
  default = {
    rke2_cert_package_url        = "" // the url to get the cert-package from
    rke2_cert_package_api_header = "" // the header to authorize getting the cert-package
    rke2_cert_package_secret     = "" // the secret to decrypt the cert package (`openssl enc -aes-256-cbc -pbkdf2)
    rke2_pre_shared_secret       = "" // the pre shared secret for `/etc/rancher/rke2/config.yaml`
  }
  sensitive = true
}

variable "rke2_node_1st_rke2_role_id" {
  description = "the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault"
  type        = string
  validation {
    condition     = var.rke2_node_1st_rke2_role_id != ""
    error_message = "the `rke2_node_1st_cert_manager_rke2_role_id` must not be empty"
  }
  sensitive = true
}

variable "rke2_node_1st_rke2_secret_id" {
  description = "the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault"
  type        = string
  validation {
    condition     = var.rke2_node_1st_rke2_secret_id != ""
    error_message = "the `rke2_node_1st_cert_manager_rke2_secret_id` must not be empty"
  }
  sensitive = true
}

variable "rke2_node_1st_cert_manager_crd_version" {
  description = "the version of cert-manager CRDs to be installed"
  type        = string
  default     = "1.11.0"
}

variable "rke2_node_1st_vault_addr" {
  description = "the vault address to put the `ke2.yml`  as kv into"
  type        = string
  default     = "" // `var.vault_addr` (implemented in rke2.tf)
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

variable "rke2_node_other_vars" {
  description = "the variables for cloud-init user data for rke2 other masters"
  type = object({
    rke2_node_1st_ip = string
  })
  default = {
    rke2_node_1st_ip = ""
  }
}
