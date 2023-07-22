locals {
  vars = [
    for configuration in var.configuration :
    {
      write_file_directory = configuration.script_file_directory,
      write_file_name      = configuration.script_file_name,
      write_file_content = templatefile(
        "${path.module}/templates/duplicacy_${configuration.command}.tpl",
        merge(
          {
            duplicacy_working_directory = configuration.working_directory,
            duplicacy_env = {
              DUPLICACY_PASSWORD = configuration.password,
            },
            duplicacy_env_special           = configuration.storage_backend_env,
            duplicacy_path                  = var.duplicacy_path,
            duplicacy_script_file_directory = configuration.script_file_directory,
          },
          jsondecode(
            configuration.command != "init" ? jsonencode({}) : jsonencode({
              duplicacy_init_options = configuration.options,
              duplicacy_snapshot_id  = configuration.snapshot_id,
              duplicacy_env_init = {
                DUPLICACY_INIT_OPTIONS = configuration.options,
              },
              duplicacy_storage_url = configuration.storage_url,
            })
          ),
          jsondecode(
            configuration.command != "backup" ? jsonencode({}) : jsonencode({
              duplicacy_log_file = "${configuration.log_file_directory}/${configuration.log_file_name}",
              duplicacy_env_backup = {
                DUPLICACY_BACKUP_OPTIONS = configuration.options,
              },
              duplicacy_backup_options               = configuration.options,
              duplicacy_pre_backup_script_file_name  = configuration.pre_script_file_name,
              duplicacy_post_backup_script_file_name = configuration.post_script_file_name,
            })
          ),
          jsondecode(
            configuration.command != "prune" ? jsonencode({}) : jsonencode({
              duplicacy_log_file = "${configuration.log_file_directory}/${configuration.log_file_name}",
              duplicacy_env_prune = {
                DUPLICACY_PRUNE_OPTIONS = configuration.options,
              },
              duplicacy_prune_options               = configuration.options,
              duplicacy_pre_prune_script_file_name  = configuration.pre_script_file_name,
              duplicacy_post_prune_script_file_name = configuration.post_script_file_name,
            })
          ),
          jsondecode(
            configuration.command != "restore" ? jsonencode({}) : jsonencode({
              duplicacy_log_file = "${configuration.log_file_directory}/${configuration.log_file_name}",
              duplicacy_env_restore = {
                DUPLICACY_RESTORE_OPTIONS = configuration.options,
              },
              duplicacy_restore_options               = configuration.options,
              duplicacy_pre_restore_script_file_name  = configuration.pre_script_file_name,
              duplicacy_post_restore_script_file_name = configuration.post_script_file_name,
            }),
          ),
        )
      ),
      write_file_owner = "root"
      write_file_group = "root"
      write_file_mode  = "755"
    }
  ]
  pre_post_script_vars = concat(
    [
      for configuration in var.configuration :
      {
        write_file_directory = configuration.script_file_directory,
        write_file_name      = configuration.pre_script_file_name,
        write_file_content   = configuration.pre_script_file_content,
        write_file_owner     = "root",
        write_file_group     = "root",
        write_file_mode      = "755",
      } if configuration.pre_script_file_content != null
    ],
    [
      for configuration in var.configuration :
      {
        write_file_directory = configuration.script_file_directory,
        write_file_name      = configuration.post_script_file_name,
        write_file_content   = configuration.post_script_file_content,
        write_file_owner     = "root",
        write_file_group     = "root",
        write_file_mode      = "755",
      } if configuration.post_script_file_content != null
    ],
  )
}