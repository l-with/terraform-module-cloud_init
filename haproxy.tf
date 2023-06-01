locals {
  haproxy_template_path = "/root"
  haproxy = !local.parts_active.haproxy ? {} : merge(
    {
      packages = [{
        template = "${path.module}/templates/haproxy/${local.yml_packages}.tpl",
        vars     = {}
      }]
    },
    var.haproxy_configuration == null ? {} : {
      write_files = [{
        template = "${path.module}/templates/haproxy/${local.yml_write_files}_haproxy_cfg.tpl"
        vars = {
          haproxy_template_path = local.haproxy_template_path
          haproxy_configuration = jsonencode(var.haproxy_configuration),
        }
      }],
    },
    var.haproxy_configuration == null ? {} : {
      runcmd = concat(
        var.haproxy_configuration == null ? [] : [{
          template = "${path.module}/templates/haproxy/${local.yml_runcmd}_haproxy_cfg.tpl"
          vars = {
            haproxy_template_path = local.haproxy_template_path
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
