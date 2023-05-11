locals {
  jq = !local.parts_active.jq ? {} : {
    packages = [{
      template = "${path.module}/templates/jq/${local.yml_packages}.tpl",
      vars     = {}
    }]
  }
}
