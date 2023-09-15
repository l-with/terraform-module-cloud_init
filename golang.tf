locals {
  golang = !local.parts_active.golang ? {} : {
    runcmd = [{
      template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
      vars = {
        packages = "golang"
      }
    }]
  }
}
