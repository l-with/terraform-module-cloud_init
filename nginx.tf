locals {
  cloud_init_nginx_comment        = ["# nginx"]
  cloud_init_nginx_package_prefix = "${path.module}/templates/nginx/cloudinit.yml.packages"

  cloud_init_nginx_package = join(
    "\n",
    local.cloud_init_nginx_comment,
    [
      templatefile("${local.cloud_init_nginx_package_prefix}.tpl", {})
    ]
  )
}

locals {
  cloud_init_nginx_gnu_add_header = var.nginx_gnu ? "add_header X-Clacks-Overhead \"GNU Terry Pratchett\";" : ""
}

locals {
  cloud_init_nginx_write_files_prefix = "${path.module}/templates/nginx/cloudinit.yml.write_files"

  cloud_init_nginx_write_files = join(
    "\n",
    concat(
      local.cloud_init_nginx_comment,
      [
        templatefile(
          "${local.cloud_init_nginx_write_files_prefix}_ssl_ecdh_curve.tpl",
          {
            configuration_home = var.nginx_configuration_home
          }
        ),
        templatefile(
          "${local.cloud_init_nginx_write_files_prefix}_http_conf.tpl",
          {
            configuration_home   = var.nginx_configuration_home
            server_name          = var.nginx_server_fqdn,
            server_fqdn          = var.nginx_server_fqdn,
            nginx_gnu_add_header = local.cloud_init_nginx_gnu_add_header
          }
        )
      ],
    )
  )
}

locals {
  cloud_init_nginx_runcmd_prefix = "${path.module}/templates/nginx/cloudinit.yml.runcmd"

  cloud_init_nginx_runcmd = join(
    "\n",
    local.cloud_init_nginx_comment,
    [
      templatefile(
        "${local.cloud_init_nginx_runcmd_prefix}.tpl",
        {
          configuration_home = var.nginx_configuration_home
          server_fqdn        = var.nginx_server_fqdn,
        }
      )
    ]
  )
}
