locals {
  gpg = !local.parts_active.gpg ? {} : {
    runcmd = [{
      template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
      vars = {
        packages = "gpg"
      }
    }]
  }
}
