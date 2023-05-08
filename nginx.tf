locals {
  cloud_init_nginx_gnu_add_header = var.nginx_gnu ? "add_header X-Clacks-Overhead \"GNU Terry Pratchett\";" : ""
}

locals {
  nginx = !var.nginx ? {} : {
    packages = [{
      template = "${path.module}/templates/nginx/${local.yml_packages}.tpl",
      vars     = {}
    }]
    write_files = concat(
      [
        {
          template = "${path.module}/templates/nginx/${local.yml_write_files}_ssl_ecdh_curve.tpl",
          vars = {
            configuration_home = var.nginx_configuration_home
          }
        }
      ],
      [
        {
          template = "${path.module}/templates/nginx/${local.yml_write_files}_http_conf.tpl",
          vars = {
            configuration_home = var.nginx_configuration_home,
            server_name        = var.nginx_server_fqdn,
            server_fqdn        = var.nginx_server_fqdn,
            gnu_add_header     = local.cloud_init_nginx_gnu_add_header
          }
        }
      ],
      [
        {
          template = "${path.module}/templates/nginx/${local.yml_write_files}_https_conf.tpl",
          vars = {
            configuration_home = var.nginx_configuration_home,
            server_name        = var.nginx_server_fqdn,
            server_fqdn        = var.nginx_server_fqdn,
            https_map          = var.nginx_https_map,
            https_conf         = join("\n      ", split("\n", var.nginx_https_conf)),
            gnu_add_header     = local.cloud_init_nginx_gnu_add_header,
            ssl_part           = templatefile("${path.module}/templates/nginx/${local.yml_write_files}_ssl_part.tpl", { fqdn = var.nginx_server_fqdn, port = 443 })
          }
        }
      ],
      [
        for conf in var.nginx_confs :
        {
          template = "${path.module}/templates/nginx/${local.yml_write_files}_https_conf.tpl",
          vars = {
            configuration_home = var.nginx_configuration_home,
            server_name        = conf.server_name,
            server_fqdn        = conf.fqdn,
            https_map          = "",
            https_conf         = join("\n      ", split("\n", conf.conf)),
            gnu_add_header     = local.cloud_init_nginx_gnu_add_header,
            ssl_part           = templatefile("${path.module}/templates/nginx/${local.yml_write_files}_ssl_part.tpl", { fqdn = conf.fqdn, port = conf.port })
          }
        }
      ]
    )
    runcmd = concat(
      [{
        template = "${path.module}/templates/nginx/${local.yml_runcmd}_https_conf.tpl",
        vars = {
          configuration_home = var.nginx_configuration_home
          server_fqdn        = var.nginx_server_fqdn,
        }
      }],
      [
        for conf in var.nginx_confs :
        {
          template = "${path.module}/templates/nginx/${local.yml_runcmd}_https_conf.tpl",
          vars = {
            configuration_home = var.nginx_configuration_home,
            server_fqdn        = conf.fqdn,
          }
        }
      ],
      [{
        template = "${path.module}/templates/nginx/${local.yml_runcmd}.tpl",
        vars = {
          configuration_home = var.nginx_configuration_home
          server_fqdn        = var.nginx_server_fqdn,
        }
      }],
    )
  }
}
