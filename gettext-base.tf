locals {
  gettext_base = !local.parts_active.gettext_base ? {} : {
    runcmd = [{
      template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
      vars = {
        packages = "gettext-base"
      }
    }]
  }
}