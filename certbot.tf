locals {
  certbot_packages = [
    "software-properties-common",
    "certbot",
  ]
  certbot = !local.parts_active.certbot ? {} : {
    runcmd = concat(
      [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
          vars = {
            packages = join(" ", local.certbot_packages),
          }
        },
        {
          template = "${path.module}/templates//${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = "/etc/cron.d",
            write_file_name      = "certbot",
            write_file_content = templatefile("${path.module}/templates/certbot/certbot_cron.tpl", {
              certbot_automatic_renewal_cron    = var.certbot_automatic_renewal_cron,
              certbot_automatic_renewal_cronjob = var.certbot_automatic_renewal_cronjob,
            }),
            write_file_owner = "root"
            write_file_group = "root"
            write_file_mode  = "644"
          },
        }
      ],
      length(var.certbot_dns_plugins) == 0 ? [] : [
        {
          template = "${path.module}/templates/certbot/${local.yml_runcmd}_install_certbot_dns_plugins.tpl",
          vars = {
            certbot_dns_plugins = jsonencode(var.certbot_dns_plugins)
          }
        },
      ],
      [for certbot_automatic_renewal_post_hook in var.certbot_automatic_renewal_post_hooks :
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = "/etc/letsencrypt/renewal-hooks/post",
            write_file_name      = certbot_automatic_renewal_post_hook.file_name,
            write_file_content   = certbot_automatic_renewal_post_hook.content,
            write_file_owner     = "root"
            write_file_group     = "root"
            write_file_mode      = "755",
          }
        }
      ]
    )
  }
}
