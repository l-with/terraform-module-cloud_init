locals {
  croc = !local.parts_active.croc ? {} : {
    runcmd = [{
      template = "${path.module}/templates/croc/${local.yml_runcmd}_install.tpl",
      vars     = {}
    }]
  }
}
