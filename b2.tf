locals {
  croc = !var.croc ? {} : {
    runcmd = [{
      template = "${path.module}/templates/b2/${local.yml_runcmd}.tpl",
      vars     = {}
    }]
  }
}
