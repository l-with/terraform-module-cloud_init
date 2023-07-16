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
    working_directory                = string,                                                                  // the working directory for duplicacy which is the default path for the repository to backup
    password                         = string,                                                                  // the value for `DUPLICACY_PASSWORD`, e.g. the passphrase to encrypt the backups with before they are stored remotely
    script_file_path                 = string,                                                                  // the path where the scripts for `duplicacy init`, `duplicacy backup`, `duplicacy restore` and `duplicacy prune` are created
    storage_backend_env              = optional(map(string), {}),                                               // the environment variables with values for the storage backend (s. https://github.com/gilbertchen/duplicacy/wiki/Managing-Passwords)
    snapshot_id                      = string,                                                                  // the `<snapshot id>` for `duplicacy init`
    storage_url                      = string,                                                                  // the `<storage url>` for ´duplicacy init`, e.g. the [Duplicacy URI](https://github.com/gilbertchen/duplicacy/wiki/Storage-Backends) of where to store the backups
    init_script_file                 = optional(string, "init"),                                                // the duplicacy init script file
    backup_script_file               = optional(string, "backup"),                                              // the duplicacy backup script file
    prune_script_file                = optional(string, "prune"),                                               // the duplicacy prune script file
    restore_script_file              = optional(string, "restore"),                                             // the duplicacy restore script file
    init_options                     = optional(string, "-encrypt"),                                            // the options for `duplicacy init`
    backup_options                   = optional(string, ""),                                                    // the options for `duplicacy backup`
    prune_options                    = optional(string, "-keep 365:3650 -keep 30:365 -keep 7:30 -keep 1:7 -a"), // the options for `duplicacy prune`
    restore_options                  = optional(string, "-overwrite"),                                          // the options for `duplicacy restore`
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
