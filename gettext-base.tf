locals {
  gettext_base = !var.gettext_base ? {} : {
    packages = [{
      template = "${path.module}/templates/gettext-base/${local.yml_packages}.tpl",
      vars     = {}
    }]
  }
}
