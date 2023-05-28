locals {
  lnxrouter_binary_path           = "/usr/local/bin"
  lnxrouter_service_template_path = "/root"
  lnxrouter = !local.parts_active.lnxrouter ? {} : merge(
    {
      packages = [{
        template = "${path.module}/templates/lnxrouter/${local.yml_packages}.tpl",
        vars     = {}
      }]
      runcmd = concat(
        [
          {
            template = "${path.module}/templates/lnxrouter/${local.yml_runcmd}_install.tpl",
            vars = {
              lnxrouter_binary_path = local.lnxrouter_binary_path,
            }
          },
        ],
        !var.lnxrouter_start ? [] : concat(
          [
            {
              template = "${path.module}/templates/lnxrouter/${local.yml_runcmd}_lnxrouter_service.tpl",
              vars = {
                lnxrouter_service_template_path = local.lnxrouter_service_template_path
                lnxrouter_ip_address            = var.lnxrouter_arguments.ip_address,
              }
            },
            {
              template = "${path.module}/templates/lnxrouter/${local.yml_runcmd}_service.tpl",
              vars     = {}
            },
          ],
        )
      )
    },
    !var.lnxrouter_start ? {} : {
      write_files = concat(
        [
          {
            template = "${path.module}/templates/lnxrouter/${local.yml_write_files}_service.tpl",
            vars = {
              lnxrouter_service_template_path = local.lnxrouter_service_template_path
              lnxrouter_binary_path           = local.lnxrouter_binary_path,
              lnxrouter_arguments             = var.lnxrouter_arguments.arguments,
            }
          },
        ],
      ),
    }
  )
}
