locals {
  jq = !local.parts_active.jq ? {} : {
    runcmd = [{
      template = "${path.module}/templates/jq/${local.yml_runcmd}_install.tpl",
      vars = {
        jq_version = var.jq_version
      }
    }]
  }
}
