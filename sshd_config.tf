locals {
  sshd_config_file                           = "/etc/ssh/sshd_config"
  sshd_config_trusted_user_ca_keys_file_name = "/etc/ssh/trusted-user-ca-keys.pem"
  sshd_config = {
    runcmd = !local.parts_active.sshd_config ? [] : concat(
      [
        {
          template = "${path.module}/templates/sshd_config/${local.yml_runcmd}_config_passwordauthentication.tpl",
          vars = {
            sshd_config_file                   = local.sshd_config_file,
            sshd_config_passwordauthentication = var.sshd_config_passwordauthentication ? "yes" : "no"
          }
        }
      ],
      var.sshd_config_trusted_user_ca_keys == null ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(local.sshd_config_trusted_user_ca_keys_file_name),
            write_file_name      = basename(local.sshd_config_trusted_user_ca_keys_file_name),
            write_file_content   = var.sshd_config_trusted_user_ca_keys,
            write_file_owner     = "root"
            write_file_group     = "root"
            write_file_mode      = "644"
          }
        },
        {
          template = "${path.module}/templates/sshd_config/${local.yml_runcmd}_config_TrustedUserCAKeys.tpl",
          vars = {
            sshd_config_file                           = local.sshd_config_file,
            sshd_config_trusted_user_ca_keys_file_name = local.sshd_config_trusted_user_ca_keys_file_name
          }
        }
      ]
    )
  }
}
