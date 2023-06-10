locals {
  jq = !local.parts_active.jq ? {} : merge(
    {
      runcmd = (var.jq_install_method != "binary") ? [] : [{
        template = "${path.module}/templates/jq/${local.yml_runcmd}_install.tpl",
        vars = {
          jq_version = var.jq_version
        }
      }],
      packages = (var.jq_install_method != "packages") ? [] : [{
        template = "${path.module}/templates/${local.yml_packages}.tpl",
        vars = {
          package = "jq",
        }
      }],
    }
  )
}
