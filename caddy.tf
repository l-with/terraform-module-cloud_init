locals {
  caddy = !local.parts_active.caddy ? {} : merge(
    {
      packages = [{
        template = "${path.module}/templates/${local.yml_packages}.tpl",
        vars = {
          package = "caddy",
        }
      }]
    },
    var.caddy_configuration == null ? {} : {
      runcmd = concat(
        var.caddy_configuration == null ? [] : [
          {
            template = "${path.module}/templates/caddy/${local.yml_runcmd}_write_file.tpl"
            vars = {
              write_file_directory = "/etc/caddy"
              write_file_name      = "Caddyfile"
              write_file_mode      = "644"
              write_file_content = templatefile("${path.module}/templates/caddy/Caddyfile.tpl", {
                caddy_configuration = var.caddy_configuration
              })
            }
          },
          {
            template = "${path.module}/templates/caddy/${local.yml_runcmd}_install.tpl",
            vars = {}
          },
          {
            template = "${path.module}/templates/caddy/${local.yml_runcmd}_restart.tpl",
            vars     = {}
          }
        ],
      )
    }
  )
}
