locals {
  unzip = !local.parts_active.unzip ? {} : {
    runcmd = [{
      template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
      vars = {
        packages = "unzip" // same with zypper
      }
    }]
  }
}
