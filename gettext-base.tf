locals {
  gettext_base = !local.parts_active.gettext_base ? {} : {
    runcmd = [{
      template = "${path.module}/templates/gettext-base/${local.yml_runcmd}_install.tpl",
      vars     = {}
    }]
  }
}
