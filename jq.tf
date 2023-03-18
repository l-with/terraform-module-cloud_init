locals {
  jq = {
    packages = [{
      template = "${path.module}/templates/jq/${local.yml_packages}.tpl",
      vars     = {}
    }]
  }
}
