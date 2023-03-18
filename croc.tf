locals {
  croc = {
    runcmd = [{
      template = "${path.module}/templates/croc/${local.yml_runcmd}.tpl",
      vars     = {}
    }]
  }
}
