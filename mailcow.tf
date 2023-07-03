locals {
  mailcow_version = var.mailcow_version != null ? var.mailcow_version : var.mailcow_branch
  mailcow = !var.mailcow ? {} : {
    runcmd = [
      {
        template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
        vars = {
          packages = "git",
        }
      },
      {
        template = "${path.module}/templates/mailcow/${local.yml_runcmd}.tpl",
        vars = {
          mailcow_install_path                  = var.mailcow_install_path,
          mailcow_version                       = local.mailcow_version,
          mailcow_hostname                      = var.mailcow_hostname,
          mailcow_branch                        = var.mailcow_branch,
          mailcow_timezone                      = var.mailcow_timezone,
          mailcow_api_key                       = var.mailcow_api_key,
          mailcow_api_key_read_only             = var.mailcow_api_key_read_only,
          mailcow_api_allow_from                = join(",", var.mailcow_api_allow_from),
          mailcow_submission_port               = var.mailcow_submission_port,
          mailcow_additional_san                = var.mailcow_additional_san,
          mailcow_acme_staging                  = var.mailcow_acme_staging,
          mailcow_acme_out_of_the_box           = var.mailcow_acme_out_of_the_box,
          mailcow_dovecot_master_auto_generated = var.mailcow_dovecot_master_auto_generated,
          mailcow_dovecot_master_user           = var.mailcow_dovecot_master_user,
          mailcow_dovecot_master_password       = var.mailcow_dovecot_master_password,
        }
      }
    ]
  }
}
