variable "mailcow" {
  description = "if cloud-init user data for installing mailcow should be generated"
  type        = bool
  default     = false
}

variable "mailcow_branch" {
  description = "the branch value for mailcow (`MAILCOW_BRANCH`)"
  type        = string
  default     = "master"
}

variable "mailcow_version" {
  description = <<EOT
    the [version](https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpathspecapathspec) to checkout
    default is [mailcow_branch](#input_mailcow_branch) (coded in terraform)
  EOT
  type        = string
  default     = null
}

variable "mailcow_install_path" {
  description = "the install path for mailcow"
  type        = string
  default     = "/opt/mailcow-dockerized"
}

variable "mailcow_hostname" {
  description = "the host name for mailcow"
  type        = string
}

variable "mailcow_timezone" {
  description = "the time zone value for mailcow (`MAILCOW_TZ`)"
  type        = string
  default     = "Europe/Berlin"
}

variable "mailcow_api_key" {
  description = "the API key for mailcow read-write access (allowed characters: a-z, A-Z, 0-9, -)"
  type        = string
  default     = null
}

variable "mailcow_api_key_read_only" {
  description = "the API key for mailcow read-only access (allowed characters: a-z, A-Z, 0-9, -)"
  type        = string
  default     = null
}

variable "mailcow_api_allow_from" {
  description = "list of IPs to allow API access from"
  type        = list(string)
  default     = []
}

variable "mailcow_submission_port" {
  description = "the SUBMISSION_PORT in mailcow.conf"
  type        = number
  default     = 587
}

variable "mailcow_additional_san" {
  description = "the additional domains (SSL Certificate Subject Alternative Names)"
  type        = string
  default     = "autodiscover.*,autoconfig.*"
}

variable "mailcow_acme_staging" {
  description = "if ACME staging should be used (s. https://mailcow.github.io/mailcow-dockerized-docs/firststeps-ssl/#test-against-staging-acme-directory)"
  type        = bool
  default     = false
}

variable "mailcow_acme_out_of_the_box" {
  description = <<EOT
    if the Let's Encrypt certificate is obtained out-of-the-box
    The 'acme-mailcow' container will try to obtain a LE certificate.
    The certbot cronjob will manage the renewal of the Let's Encrypt certificates.
  EOT
  type        = bool
  default     = true
}

variable "mailcow_dovecot_master_auto_generated" {
  description = "if the dovecot master user and password should be auto-generated "
  type        = bool
  default     = true
}

variable "mailcow_dovecot_master_user" {
  description = "the username of the dovecot master user (DOVECOT_MASTER_USER) if not auto-generated"
  type        = string
  default     = null
}

variable "mailcow_dovecot_master_password" {
  description = "the password for the dovecot master user (DOVECOT_MASTER_PASS) if not auto-generated"
  type        = string
  default     = null
}

variable "mailcow_docker_compose_project_name" {
  description = "the name for the mailcow docker compose project"
  type        = string
  default     = "mailcow_dockerized"
}

variable "mailcow_delete_default_admin_script" {
  description = "the path for the mailcow delete admin script"
  type        = string
  default     = "/root/mailcow_delete_default_admin.sh"
}

variable "mailcow_set_admin_script" {
  description = "the path for the mailcow set admin script"
  type        = string
  default     = "/root/mailcow_set_admin.sh"
}

variable "mailcow_admin_user" {
  description = "the username of the mailcow administrator"
  type        = string
  default     = null
}

variable "mailcow_admin_password" {
  description = "the password for the mailcow administrator"
  type        = string
  default     = null
}