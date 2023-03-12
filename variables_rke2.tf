variable "rke2_master_1st" {
  description = "if cloud-init user data for the rke2 1st masters should be generated"
  type        = bool
  default     = false
}

variable "rke2_master_other" {
  description = "if cloud-init user data for the rke2 other masters should be generated"
  type        = bool
  default     = false
}

variable "rke2_master_vars" {
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
    rke2_cert_package_secret     = "" // the secret to decrypt the cert package (`openssl enc -aes-256-cbc -pbkdf2`)
    rke2_pre_shared_secret       = ""
  }
  sensitive = true
}

variable "rke2_master_1st_vars" {
  description = "the variables for cloud-init user data for rke2 1st master"
  type = object({
    rke2_role_id             = string // the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault
    rke2_secret_id           = string // the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault
    cert_manager_crd_version = string // the version of cert-manager CRDs to be installed
    vault_addr               = string // the vault address
    vault_mount              = string // the vault mount used to put the `rke2.yaml` as kv into vault
    vault_path               = string // the vault path used to put the `rke2.yaml` as kv into vault
    vault_field              = string // the vault field used to put the `rke2.yaml` as kv into vault
  })
  default = {
    rke2_role_id             = ""
    rke2_secret_id           = ""
    cert_manager_crd_version = "1.11.0"
    vault_addr               = "" // var.vault_addr (implemented in rke2.tf)
    vault_mount              = "gitlab"
    vault_path               = "rancher/kubeconfig"
    vault_field              = "rke2_yaml"
  }
  sensitive = true
}

variable "rke2_master_other_vars" {
  description = "the variables for cloud-init user data for rke2 other masters"
  type = object({
    rke2_master1_ip = string
  })
  default = {
    rke2_master1_ip = ""
  }
}
