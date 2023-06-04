locals {
  certbot = !local.parts_active.certbot ? {} : {
    packages = concat(
      [
        {
          template = "${path.module}/templates/certbot/${local.yml_packages}.tpl",
          vars     = {},
        }
      ],
      !var.certbot_dns_hetzner ? [] : [
        {
          template = "${path.module}/templates/certbot/${local.yml_packages}_certbot_dns_hetzner.tpl",
          vars     = {},
        }
      ]
    ),
    write_files = [{
      template = "${path.module}/templates/certbot/${local.yml_write_files}_cron.tpl",
      vars = {
        certbot_automatic_renewal_cron    = var.certbot_automatic_renewal_cron,
        certbot_automatic_renewal_cronjob = var.certbot_automatic_renewal_cronjob,
      },
    }]
    runcmd = !var.certbot_dns_hetzner ? [] : concat(
      [
        {
          template = "${path.module}/templates/certbot/${local.yml_runcmd}_install.tpl",
          vars     = {}
        },
      ],
      [for certbot_automatic_renewal_post_hook in var.certbot_automatic_renewal_post_hooks :
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = "/etc/letsencrypt/renewal-hooks/post",
            write_file_name      = certbot_automatic_renewal_post_hook.file_name,
            write_file_content   = certbot_automatic_renewal_post_hook.content,
            write_file_mode      = "644",
          }
        }
      ]
    )
  }
}
