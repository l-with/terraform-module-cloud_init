locals {
  python3_pip = !local.parts_active.python3_pip ? {} : {
    packages = [{
      template = "${path.module}/templates/${local.yml_packages}.tpl",
      vars = {
        package = "python3-pip"
      }
    }]
  }
}
