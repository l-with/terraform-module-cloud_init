locals {
  gettext_base = !local.parts_active.gettext_base ? {} : {
    packages = [{
      template = "${path.module}/templates/gettext-base/${local.yml_packages}.tpl",
      vars     = {}
    }]
  }
}
