variable "mailcow" {
  description = "if cloud-init user data for installing mailcow should be generated"
  type        = bool
  default     = false
}

variable "mailcow_version" {
  description = <<EOT
    the [version](https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpathspecapathspec) to checkout
    and the value for `MAILCOW_BRANCH` (can be also be a tag)
  EOT
  type        = string
  default     = "master"
}

variable "mailcow_install_path" {
  description = "the install path for mailcow"
  type        = string
  default     = "/opt/mailcow-dockerized"
}

variable "mailcow_hostname" {
  description = "the host name for mailcow"
  type        = string
  default     = null
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
  description = <<EOT
    the [postfix submission](https://docs.mailcow.email/prerequisite/prerequisite-system/?h=submission#default-ports) port (SUBMISSION_PORT in mailcow.conf)
  EOT
  type        = number
  default     = null
}

variable "mailcow_additional_san" {
  description = "the additional domains (SSL Certificate Subject Alternative Names), for instance autodiscover.*,autoconfig.*"
  type        = string
  default     = null
}

variable "mailcow_acme_staging" {
  description = "if ACME staging should be used (s. https://mailcow.github.io/mailcow-dockerized-docs/firststeps-ssl/#test-against-staging-acme-directory)"
  type        = bool
  default     = false
}

variable "mailcow_acme" {
  description = <<EOT
    the way the Let's Encrypt certificate ist obtained:
    `out-the-box`:  The "acme-mailcow" container will try to obtain a LE certificate.
    `certbot`: The certbot cronjob will manage Let's Encrypt certificates
    if the Let's Encrypt certificate is obtained out-of-the-box
  EOT
  type        = string
  default     = "out-of-the-box"
  validation {
    condition     = contains(["out-of-the-box", "certbot"], var.mailcow_acme)
    error_message = "Supported values are 'out-the-box', 'certbot'."
  }
}

variable "mailcow_certbot_post_hook_script" {
  description = "the full path for the mailcow certbot post-hook script"
  type        = string
  default     = "/etc/letsencrypt/renewal-hooks/post/mailcow_certbot_post_hook.sh"
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
  default     = null
}

variable "mailcow_delete_default_admin_script" {
  description = "the full path for the mailcow delete admin script"
  type        = string
  default     = "/root/mailcow_delete_default_admin.sh"
}

variable "mailcow_set_admin_script" {
  description = "the full path for the mailcow set admin script"
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

variable "mailcow_set_rspamd_ui_password_script" {
  description = "the full path for the mailcow set Rspamd UI password script"
  type        = string
  default     = "/root/mailcow_set_rspamd_ui_password.sh"
}

variable "mailcow_rspamd_ui_password" {
  description = "the password for the mailcow Rspamd UI"
  type        = string
  default     = null
}

variable "mailcow_greylisting" {
  description = "if greylisting should be active"
  type        = bool
  default     = true
}

variable "mailcow_mynetworks" {
  description = <<EOT
    the list of subnetwork masks to add to `mynetworks` in postfix
    if subnetwork masks are provided at the beginning `127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 [fe80::]/10` is added (local)
  EOT
  type        = list(string)
  default     = []
}

variable "mailcow_configure_backup" {
  description = "if backup for mailcow should be configured for unattended backup"
  type        = bool
  default     = false
}

variable "mailcow_backup_script" {
  description = "the full path for the mailcow backup script"
  type        = string
  default     = "/opt/mailcow/scripts/mailcow-backup.sh"
}

variable "mailcow_restore_script" {
  description = "the full path for the mailcow restore script"
  type        = string
  default     = "/opt/mailcow/scripts/mailcow-restore.sh"
}

variable "mailcow_backup_path" {
  description = "the path for the mailcow backup"
  type        = string
  default     = "/var/backups/mailcow"
}
