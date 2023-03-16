locals {
  cloud_init_comment_nginx        = ["# nginx"]
  cloud_init_package_nginx_prefix = "${path.module}/templates/nginx/cloudinit.yml.packages"

  cloud_init_package_nginx = join(
    "\n",
    local.cloud_init_comment_nginx,
    [
      templatefile("${local.cloud_init_package_nginx_prefix}.tpl", {})
    ]
  )
}

locals {
  cloud_init_nginx_gnu_add_header = var.nginx_gnu ? "add_header X-Clacks-Overhead \"GNU Terry Pratchett\";" : ""
  cloud_init_nginx_https_conf     = join("\n      ", split("\n", var.nginx_https_conf))
}

locals {
  cloud_init_write_files_nginx_prefix = "${path.module}/templates/nginx/cloudinit.yml.write_files"

  cloud_init_write_files_nginx = join(
    "\n",
    concat(
      local.cloud_init_comment_nginx,
      [
        templatefile(
          "${local.cloud_init_write_files_nginx_prefix}_ssl_ecdh_curve.tpl",
          {
            configuration_home = var.nginx_configuration_home
          }
        ),
        templatefile(
          "${local.cloud_init_write_files_nginx_prefix}_http_conf.tpl",
          {
            configuration_home = var.nginx_configuration_home,
            server_name        = var.nginx_server_fqdn,
            server_fqdn        = var.nginx_server_fqdn,
            gnu_add_header     = local.cloud_init_nginx_gnu_add_header
          }
        ),
        templatefile(
          "${local.cloud_init_write_files_nginx_prefix}_https_conf.tpl",
          {
            configuration_home = var.nginx_configuration_home,
            server_name        = var.nginx_server_fqdn,
            server_fqdn        = var.nginx_server_fqdn,
            https_map          = var.nginx_https_map,
            https_conf         = local.cloud_init_nginx_https_conf,
            gnu_add_header     = local.cloud_init_nginx_gnu_add_header,
            ssl_part           = templatefile("${local.cloud_init_write_files_nginx_prefix}_ssl_part.tpl", { fqdn = var.nginx_server_fqdn, port = 443 })
          }
        )
      ],
      [
        for conf in var.nginx_confs :
        templatefile(
          "${local.cloud_init_write_files_nginx_prefix}_https_conf.tpl",
          {
            configuration_home = var.nginx_configuration_home,
            server_name        = conf.server_name,
            server_fqdn        = conf.fqdn,
            https_map          = "",
            https_conf         = join("\n      ", split("\n", conf.conf)),
            gnu_add_header     = local.cloud_init_nginx_gnu_add_header,
            ssl_part           = templatefile("${local.cloud_init_write_files_nginx_prefix}_ssl_part.tpl", { fqdn = conf.fqdn, port = conf.port })
          }
        )
      ]
    )
  )
}

locals {
  cloud_init_runcmd_nginx_prefix = "${path.module}/templates/nginx/cloudinit.yml.runcmd"

  cloud_init_runcmd_nginx = join(
    "\n",
    local.cloud_init_comment_nginx,
    [
      templatefile(
        "${local.cloud_init_runcmd_nginx_prefix}.tpl",
        {
          configuration_home = var.nginx_configuration_home
          server_fqdn        = var.nginx_server_fqdn,
        }
      )
    ]
  )
}
