variable "configuration" {
  type = list(object({
    working_directory        = string,                    // the working directory for duplicacy which is the default path for the repository to backup
    command                  = string,                    // the script (init, backup, prune, restore)
    script_file_path         = string,                    // the path where the scripts for `duplicacy init`, `duplicacy backup`, `duplicacy restore` and `duplicacy prune` are created
    script_file              = string,                    // the duplicacy command
    password                 = string,                    // the value for `DUPLICACY_PASSWORD`, e.g. the passphrase to encrypt the backups with before they are stored remotely
    options                  = string,                    // the options for `duplicacy <script>`
    storage_backend_env      = optional(map(string), {}), // the environment variables with values for the storage backend (s. https://github.com/gilbertchen/duplicacy/wiki/Managing-Passwords)
    snapshot_id              = string,                    // the `<snapshot id>` for `duplicacy init`
    storage_url              = string,                    // the `<storage url>` for ´duplicacy init`, e.g. the [Duplicacy URI](https://github.com/gilbertchen/duplicacy/wiki/Storage-Backends) of where to store the backups
    pre_script_file_name     = optional(string),          // the file name of the pre script
    post_script_file_name    = optional(string),          // the file name of the post script
    pre_script_file_content  = optional(string, null),    // the content for the pre script
    post_script_file_content = optional(string, null),    // the content for the pre script
  }))
}

variable "yml_prefix" {
  type = string
}

variable "duplicacy_path" {
  type = string
}