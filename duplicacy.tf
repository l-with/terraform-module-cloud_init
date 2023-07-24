locals {
  duplicacy_command_scripts = [
    "init", "backup", "prune", "restore"
  ]
  duplicacy_storage_backend_local_disk        = "Local disk"
  duplicacy_storage_backend_blackblaze_b2     = "Backblaze B2"
  duplicacy_storage_backend_ssh_sftp_password = "SSH/SFTP Password"
  duplicacy_storage_backend_ssh_sftp_keyfile  = "SSH/SFTP Keyfile"
  duplicacy_storage_backend_onedrive          = "Onedrive"
  duplicacy_storage_backends = [
    local.duplicacy_storage_backend_local_disk,
    local.duplicacy_storage_backend_blackblaze_b2,
    local.duplicacy_storage_backend_ssh_sftp_password,
    local.duplicacy_storage_backend_ssh_sftp_keyfile,
    local.duplicacy_storage_backend_onedrive,
  ]
  duplicacy_storage_backend_configurations = [
    for configuration in var.duplicacy_configurations : {
      storage_backend_env = (configuration.storage_backend == local.duplicacy_storage_backend_blackblaze_b2 ?
        {
          DUPLICACY_B2_ID  = configuration.b2_id,
          DUPLICACY_B2_KEY = configuration.b2_key,
        }
        : (configuration.storage_backend == local.duplicacy_storage_backend_ssh_sftp_password ?
          {
            DUPLICACY_SSH_PASSWORD = configuration.ssh_password,
          }
          : (configuration.storage_backend == local.duplicacy_storage_backend_ssh_sftp_keyfile) ?
          {
            DUPLICACY_SSH_KEY_FILE   = configuration.ssh_key_file_name,
            DUPLICACY_SSH_PASSPHRASE = configuration.ssh_passphrase,
          }
          : (configuration.storage_backend == local.duplicacy_storage_backend_onedrive) ?
          {
            DUPLICACY_ONE_TOKEN = configuration.onedrive_token_file_name,
          }
      : {}))
    }
  ]
  duplicacy_command_specific_configurations = [
    for configuration in var.duplicacy_configurations :
    {
      init = {
        options                  = configuration.init_options,
        script_file_name         = configuration.init_script_file_name,
        log_file_name            = null,
        pre_script_file_name     = null
        post_script_file_name    = null
        pre_script_file_content  = null,
        post_script_file_content = null,
      }
      backup = {
        options                  = configuration.backup_options,
        script_file_name         = configuration.backup_script_file_name,
        log_file_name            = configuration.backup_log_file_name,
        pre_script_file_name     = configuration.pre_backup_script_file_name,
        post_script_file_name    = configuration.post_backup_script_file_name,
        pre_script_file_content  = configuration.pre_backup_script_file_content,
        post_script_file_content = configuration.post_backup_script_file_content,
      }
      prune = {
        options                  = configuration.prune_options,
        script_file_name         = configuration.prune_script_file_name,
        log_file_name            = configuration.prune_log_file_name,
        pre_script_file_name     = configuration.pre_prune_script_file_name,
        post_script_file_name    = configuration.post_prune_script_file_name,
        pre_script_file_content  = configuration.pre_prune_script_file_content,
        post_script_file_content = configuration.post_prune_script_file_content,
      }
      restore = {
        options                  = configuration.restore_options,
        script_file_name         = configuration.restore_script_file_name,
        log_file_name            = configuration.restore_log_file_name,
        pre_script_file_name     = configuration.pre_restore_script_file_name,
        post_script_file_name    = configuration.post_restore_script_file_name,
        pre_script_file_content  = configuration.pre_restore_script_file_content,
        post_script_file_content = configuration.post_restore_script_file_content,
      }
    }
  ]
}

module "duplicacy_script" {
  count = length(var.duplicacy_configurations)

  source = "./modules/duplicacy_script"

  duplicacy_path = var.duplicacy_path
  yml_prefix     = local.yml_runcmd
  configuration = [
    for script in local.duplicacy_command_scripts :
    {
      working_directory        = var.duplicacy_configurations[count.index].working_directory,
      command                  = script,
      script_file_directory    = var.duplicacy_configurations[count.index].script_file_directory,
      log_file_directory       = var.duplicacy_configurations[count.index].log_file_directory,
      password                 = var.duplicacy_configurations[count.index].password,
      storage_backend_env      = local.duplicacy_storage_backend_configurations[count.index].storage_backend_env,
      snapshot_id              = var.duplicacy_configurations[count.index].snapshot_id,
      storage_url              = var.duplicacy_configurations[count.index].storage_url,
      options                  = local.duplicacy_command_specific_configurations[count.index][script].options,
      script_file_name         = local.duplicacy_command_specific_configurations[count.index][script].script_file_name,
      log_file_name            = local.duplicacy_command_specific_configurations[count.index][script].log_file_name,
      pre_script_file_name     = local.duplicacy_command_specific_configurations[count.index][script].pre_script_file_name,
      post_script_file_name    = local.duplicacy_command_specific_configurations[count.index][script].post_script_file_name,
      pre_script_file_content  = local.duplicacy_command_specific_configurations[count.index][script].pre_script_file_content,
      post_script_file_content = local.duplicacy_command_specific_configurations[count.index][script].post_script_file_content,
    }
  ]
}

locals {
  duplicacy = merge(
    {
      runcmd = !local.parts_active.duplicacy ? [] : concat(
        [
          {
            template = "${path.module}/templates/duplicacy/${local.yml_runcmd}_install.tpl",
            vars = {
              duplicacy_path    = var.duplicacy_path,
              duplicacy_version = var.duplicacy_version,
            }
          },
        ],
        [
          for configuration in var.duplicacy_configurations :
          {
            template = "${path.module}/templates/${local.yml_runcmd}_mkdir.tpl",
            vars = {
              jsonencoded_directories = jsonencode([
                configuration.working_directory,
                configuration.secret_file_directory,
                configuration.log_file_directory,
              ]),
            },
          }
        ],
        flatten(
          [
            for configuration in var.duplicacy_configurations :
            {
              template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
              vars = {
                write_file_directory = configuration.secret_file_directory,
                write_file_name = (configuration.storage_backend == local.duplicacy_storage_backend_onedrive ?
                  configuration.onedrive_token_file_name
                  : (configuration.storage_backend == local.duplicacy_storage_backend_ssh_sftp_keyfile) ?
                  configuration.ssh_key_file_name
                : null),
                write_file_content = configuration.secret_file_content,
                write_file_mode    = "755"
                write_file_group   = "root"
                write_file_owner   = "root"
              }
            }
            if contains(
              [
                local.duplicacy_storage_backend_onedrive,
                local.duplicacy_storage_backend_ssh_sftp_keyfile,
              ],
              configuration.storage_backend
            )
          ]
        ),
        flatten(
          [
            for duplicacy_script in module.duplicacy_script :
            [
              for vars in duplicacy_script.vars :
              {
                template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
                vars     = vars,
              }
            ]
          ]
        ),
        flatten(
          [
            for duplicacy_script in module.duplicacy_script :
            [
              for pre_post_script_vars in duplicacy_script.pre_post_scripts_vars :
              {
                template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
                vars     = pre_post_script_vars,
              }
            ]
          ]
        ),
        [
          for configuration in var.duplicacy_configurations :
          {
            template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
            vars = {
              runcmd_script = "  - ${configuration.script_file_directory}/${configuration.init_script_file_name}"
            }
          }
        ],
      )
    },
  )
}
