locals {
  python3_pip = !local.parts_active.python3_pip ? {} : {
    packages = [{
      template = "${path.module}/templates/python3-pip/${local.yml_packages}.tpl",
      vars     = {}
    }]
  }
}
