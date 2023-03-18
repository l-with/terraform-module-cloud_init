locals {
  vault = {
    packages = [{
      template = "${path.module}/templates/vault/${local.yml_packages}.tpl",
      vars     = {}
    }]
    runcmd = [{
      template = "${path.module}/templates/vault/${local.yml_runcmd}.tpl",
      vars     = {}
    }]
  }
}
