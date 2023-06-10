locals {
  haproxy = !local.parts_active.haproxy ? {} : merge(
    {
      packages = [{
        template = "${path.module}/templates/${local.yml_packages}.tpl",
        vars = {
          package = "haproxy",
        }
      }]
    },
    var.haproxy_configuration == null ? {} : {
      runcmd = concat(
        var.haproxy_configuration == null ? [] : [{
          template = "${path.module}/templates/haproxy/${local.yml_runcmd}_write_file.tpl"
          vars = {
            write_file_directory = "/etc/haproxy"
            write_file_name      = "haproxy.cfg"
            write_file_mode      = "644"
            write_file_content = templatefile("${path.module}/templates/haproxy/haproxy_cfg.tpl", {
              haproxy_configuration = var.haproxy_configuration
            })
          }
        }],
        [{
          template = "${path.module}/templates/haproxy/${local.yml_runcmd}_restart.tpl",
          vars     = {}
        }],
      )
    }
  )
}
