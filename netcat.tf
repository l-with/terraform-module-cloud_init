locals {
  netcat = !local.parts_active.netcat ? {} : {
    runcmd = [{
      template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
      vars = {
        packages = "netcat"
      }
    }]
  }
}
