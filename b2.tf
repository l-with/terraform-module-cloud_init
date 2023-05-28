locals {
  b2 = !local.parts_active.b2 ? {} : {
    runcmd = [{
      template = "${path.module}/templates/b2/${local.yml_runcmd}_install.tpl",
      vars     = {}
    }]
  }
}
