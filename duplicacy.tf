locals {
  duplicacy_command_scripts = [
    "init", "backup", "prune", "restore"
  ]
  duplicacy_command_specific_configurations = [
    for configuration in var.duplicacy_configurations :
    {
      init = {
        options                  = configuration.init_options,
        script_file              = configuration.init_script_file,
        pre_script_file_name     = null
        post_script_file_name    = null
        pre_script_file_content  = null,
        post_script_file_content = null,
      }
      backup = {
        options                  = configuration.backup_options,
        script_file              = configuration.backup_script_file,
        pre_script_file_name     = configuration.pre_backup_script_file_name,
        post_script_file_name    = configuration.post_backup_script_file_name,
        pre_script_file_content  = configuration.pre_backup_script_file_content,
        post_script_file_content = configuration.post_backup_script_file_content,
      }
      prune = {
        options                  = configuration.prune_options,
        script_file              = configuration.prune_script_file,
        pre_script_file_name     = configuration.pre_prune_script_file_name,
        post_script_file_name    = configuration.post_prune_script_file_name,
        pre_script_file_content  = configuration.pre_prune_script_file_content,
        post_script_file_content = configuration.post_prune_script_file_content,
      }
      restore = {
        options                  = configuration.restore_options,
        script_file              = configuration.restore_script_file,
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
      script_file_path         = var.duplicacy_configurations[count.index].script_file_path,
      password                 = var.duplicacy_configurations[count.index].password,
      storage_backend_env      = var.duplicacy_configurations[count.index].storage_backend_env,
      snapshot_id              = var.duplicacy_configurations[count.index].snapshot_id,
      storage_url              = var.duplicacy_configurations[count.index].storage_url,
      options                  = local.duplicacy_command_specific_configurations[count.index][script].options,
      script_file              = local.duplicacy_command_specific_configurations[count.index][script].script_file,
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
            template = "${path.module}/templates/duplicacy/${local.yml_runcmd}_configuration.tpl",
            vars = {
              duplicacy_working_directory = configuration.working_directory,
            },
          }
        ],
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
      )
    },
  )
}