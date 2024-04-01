locals {
  mailcow_version     = var.mailcow_version != null ? var.mailcow_version : var.mailcow_branch
  mailcow_skip_branch = var.mailcow_version != null
  mailcow = !local.parts_active.mailcow ? {} : {
    runcmd = concat(
      [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
          vars = {
            packages = "git", // same with zypper
          }
        },
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}_install.tpl",
          vars = {
            mailcow_install_path                  = var.mailcow_install_path,
            mailcow_version                       = local.mailcow_version,
            mailcow_skip_branch                   = local.mailcow_skip_branch ? "y" : "n",
            mailcow_branch                        = var.mailcow_branch,
            mailcow_hostname                      = var.mailcow_hostname,
            mailcow_docker_compose_project_name   = var.mailcow_docker_compose_project_name,
            mailcow_timezone                      = var.mailcow_timezone,
            mailcow_api_key                       = var.mailcow_api_key,
            mailcow_api_key_read_only             = var.mailcow_api_key_read_only,
            mailcow_api_allow_from                = join(",", var.mailcow_api_allow_from),
            mailcow_submission_port               = var.mailcow_submission_port,
            mailcow_additional_san                = var.mailcow_additional_san,
            mailcow_acme_staging                  = var.mailcow_acme_staging,
            mailcow_acme                          = var.mailcow_acme,
            mailcow_dovecot_master_auto_generated = var.mailcow_dovecot_master_auto_generated,
            mailcow_dovecot_master_user           = var.mailcow_dovecot_master_user,
            mailcow_dovecot_master_password       = var.mailcow_dovecot_master_password,
            mailcow_allow_admin_email_login       = var.mailcow_allow_admin_email_login,
          }
        },
      ],
      var.mailcow_acme != "certbot" ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(var.mailcow_certbot_post_hook_script),
            write_file_name      = basename(var.mailcow_certbot_post_hook_script),
            write_file_content = templatefile("${path.module}/templates/mailcow/mailcow_certbot_post_hook.sh.tpl", {
              mailcow_hostname = var.mailcow_hostname,
            }),
            write_file_owner = "root"
            write_file_group = "root"
            write_file_mode  = "755",
          }
        },
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}_certbot.tpl",
          vars = {
            mailcow_hostname = var.mailcow_hostname,
          }
        },
      ],
      var.mailcow_greylisting ? [] : [
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}_disable_greylist.tpl",
          vars = {
            mailcow_install_path = var.mailcow_install_path,
          }
        },
      ],
      length(var.mailcow_rspamd_ip_whitelist) == 0 ? [] : [
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}_add_ip_whitelist.tpl",
          vars = {
            mailcow_install_path = var.mailcow_install_path,
            mailcow_rspamd_ip_whitelist   = join("\n", var.mailcow_rspamd_ip_whitelist),
          }
        },
      ],
      length(var.mailcow_mynetworks) == 0 ? [] : [
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}_mynetworks.tpl",
          vars = {
            mailcow_install_path = var.mailcow_install_path,
            mailcow_mynetworks   = join(" ", var.mailcow_mynetworks),
          }
        },
      ],
      [
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}.tpl",
          vars = {
            mailcow_install_path = var.mailcow_install_path,
            mailcow_hostname     = var.mailcow_hostname,
          }
        },
      ],
      var.mailcow_admin_user == null ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(var.mailcow_delete_default_admin_script),
            write_file_name      = basename(var.mailcow_delete_default_admin_script),
            write_file_content   = templatefile("${path.module}/templates/mailcow/mailcow_delete_default_admin.sh.tpl", {}),
            write_file_owner     = "root"
            write_file_group     = "root"
            write_file_mode      = "755",
          }
        },
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(var.mailcow_set_admin_script),
            write_file_name      = basename(var.mailcow_set_admin_script),
            write_file_content   = templatefile("${path.module}/templates/mailcow/mailcow_set_admin.sh.tpl", {}),
            write_file_owner     = "root"
            write_file_group     = "root"
            write_file_mode      = "755",
          }
        },
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}_bootstrap_admin.tpl",
          vars = {
            mailcow_install_path                = var.mailcow_install_path,
            mailcow_delete_default_admin_script = var.mailcow_delete_default_admin_script,
            mailcow_admin_user                  = var.mailcow_admin_user,
            mailcow_admin_password              = var.mailcow_admin_password,
            mailcow_set_admin_script            = var.mailcow_set_admin_script,
          }
        },
      ],
      var.mailcow_rspamd_ui_password == null ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(var.mailcow_set_rspamd_ui_password_script),
            write_file_name      = basename(var.mailcow_set_rspamd_ui_password_script),
            write_file_content   = templatefile("${path.module}/templates/mailcow/mailcow_set_rspamd_ui_password.sh.tpl", {}),
            write_file_owner     = "root"
            write_file_group     = "root"
            write_file_mode      = "755",
          }
        },
        {
          template = "${path.module}/templates/mailcow/${local.yml_runcmd}_bootstrap_rspamd_ui.tpl",
          vars = {
            mailcow_install_path                  = var.mailcow_install_path,
            mailcow_delete_default_admin_script   = var.mailcow_delete_default_admin_script,
            mailcow_admin_user                    = var.mailcow_admin_user,
            mailcow_admin_password                = var.mailcow_admin_password,
            mailcow_set_admin_script              = var.mailcow_set_admin_script,
            mailcow_rspamd_ui_password            = var.mailcow_rspamd_ui_password,
            mailcow_set_rspamd_ui_password_script = var.mailcow_set_rspamd_ui_password_script,
          }
        },
      ],
      !var.mailcow_configure_backup ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_mkdir.tpl",
          vars = {
            jsonencoded_directories = jsonencode([var.mailcow_backup_path])
          }
        },
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(var.mailcow_backup_script),
            write_file_name      = basename(var.mailcow_backup_script),
            write_file_content = templatefile("${path.module}/templates/mailcow/mailcow_backup.sh.tpl", {
              mailcow_backup_path  = var.mailcow_backup_path
              mailcow_install_path = var.mailcow_install_path,
            }),
            write_file_owner = "root"
            write_file_group = "root"
            write_file_mode  = "755",
          }
        },
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(var.mailcow_restore_script),
            write_file_name      = basename(var.mailcow_restore_script),
            write_file_content = templatefile("${path.module}/templates/mailcow/mailcow_restore.sh.tpl", {
              mailcow_backup_path  = var.mailcow_backup_path
              mailcow_install_path = var.mailcow_install_path,
            }),
            write_file_owner = "root"
            write_file_group = "root"
            write_file_mode  = "755",
          }
        },
      ]
    )
  }
}
