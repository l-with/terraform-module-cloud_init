locals {
  b2 = !var.b2 ? {} : {
    runcmd = [{
      template = "${path.module}/templates/b2/${local.yml_runcmd}.tpl",
      vars     = {}
    }]
  }
}
