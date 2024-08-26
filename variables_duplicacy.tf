variable "duplicacy" {
  description = "if cloud-init user data for installing duplicacy should be generated"
  type        = bool
  default     = false
}

variable "duplicacy_path" {
  description = "the path to install duplicacy"
  type        = string
  default     = "/opt/duplicacy"
}

variable "duplicacy_version" {
  description = "the duplicacy version to install"
  type        = string
  default     = "3.1.0"
}

variable "duplicacy_configurations" {
  description = "the duplicacy configurations"
  type = list(object({
    working_directory     = string, // the working directory for duplicacy which is the default path for the repository to backup
    password              = string, // the value for `DUPLICACY_PASSWORD`, e.g. the passphrase to encrypt the backups with before they are stored remotely
    script_file_directory = string, // the path where the scripts for `duplicacy init`, `duplicacy backup`, `duplicacy restore` and `duplicacy prune` are created

    storage_backend                  = string,                                                                  // the storage backend, possible values are `Local disk`, `Backblaze B2`, `SSH/SFTP Password`, `SSH/SFTP Keyfile`, `Onedrive`
    b2_id                            = optional(string),                                                        // the value for `DUPLICACY_B2_ID`
    b2_key                           = optional(string),                                                        // the value for `DUPLICACY_B2_KEY`
    ssh_password                     = optional(string),                                                        // the value for `DUPLICACY_SSH_PASSWORD`
    ssh_passphrase                   = optional(string),                                                        // the value for `DUPLICACY_SSH_PASSPHRASE`
    secret_file_directory            = optional(string, "/opt/duplicacy/secret"),                               // the path where the token and the ssh-key files are created
    onedrive_token_file_name         = optional(string, "one-token.json"),                                      // the filename for `DUPLICACY_ONE_TOKEN`
    ssh_key_file_name                = optional(string, "id"),                                                  // the filename for `DUPLICACY_SSH_KEY_FILE`
    secret_file_content              = optional(string),                                                        // the content for onedrive_token_file_name or ssh_key_file_name
    snapshot_id                      = string,                                                                  // the `<snapshot id>` for `duplicacy init`
    storage_url                      = string,                                                                  // the `<storage url>` for `duplicacy init`, e.g. the [Duplicacy URI](https://github.com/gilbertchen/duplicacy/wiki/Storage-Backends) of where to store the backups
    init_script_file_name            = optional(string, "init"),                                                // the duplicacy init script file name
    backup_script_file_name          = optional(string, "backup"),                                              // the duplicacy backup script file name
    prune_script_file_name           = optional(string, "prune"),                                               // the duplicacy prune script file name
    restore_script_file_name         = optional(string, "restore"),                                             // the duplicacy restore script file name
    init_options                     = optional(string, "-encrypt"),                                            // the options for `duplicacy init`
    backup_options                   = optional(string, ""),                                                    // the options for `duplicacy backup`
    prune_options                    = optional(string, "-keep 365:3650 -keep 30:365 -keep 7:30 -keep 1:7 -a"), // the options for `duplicacy prune`
    restore_options                  = optional(string, "-overwrite"),                                          // the options for `duplicacy restore`
    log_file_directory               = optional(string, "/opt/mailcow/duplicacy/log"),                          // the directory for the script log files
    backup_log_file_name             = optional(string, "backup.log"),                                          // the file name of the backup log file
    prune_log_file_name              = optional(string, "prune.log"),                                           // the file name of the prune log file
    restore_log_file_name            = optional(string, "restore.log"),                                         // the file name of the restore log file
    pre_backup_script_file_name      = optional(string, "pre-backup"),                                          // the file name of the pre backup script
    post_backup_script_file_name     = optional(string, "post-backup"),                                         // the file name of the post backup script
    pre_prune_script_file_name       = optional(string, "pre-prune"),                                           // the file name of the pre prune script
    post_prune_script_file_name      = optional(string, "post-prune"),                                          // the file name of the post prune script
    pre_restore_script_file_name     = optional(string, "pre-restore"),                                         // the file name of the pre restore script
    post_restore_script_file_name    = optional(string, "post-restore"),                                        // the file name of the post restore script
    pre_backup_script_file_content   = optional(string, null),                                                  // the content for the pre backup script
    post_backup_script_file_content  = optional(string, null),                                                  // the content for the pre backup script
    pre_prune_script_file_content    = optional(string, null),                                                  // the content for the pre prune script
    post_prune_script_file_content   = optional(string, null),                                                  // the content for the pre prune script
    pre_restore_script_file_content  = optional(string, null),                                                  // the content for the pre restore script
    post_restore_script_file_content = optional(string, null),                                                  // the content for the pre restore script
  }))
  default = []
}
