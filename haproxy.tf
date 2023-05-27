locals {
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
          haproxy_configuration = var.haproxy_configuration,
        }
      }],
    },
    var.haproxy_configuration == null ? {} : {
      run_cmd = [{
        template = "${path.module}/templates/haproxy/${local.yml_runcmd}_restart.tpl",
        vars     = {}
      }]
    }
  )
}
