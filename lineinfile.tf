locals {
  lineinfile = {
    runcmd = !local.parts_active.lineinfile ? [] : [{
      template = "${path.module}/templates/lineinfile/${local.yml_runcmd}_install.tpl",
      vars     = {}
    }]
  }
}
