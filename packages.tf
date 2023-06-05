locals {
  packages = {
    packages = [for index, package in var.packages : {
      template = "${path.module}/templates/${local.yml_packages}.tpl",
      vars = {
        package = package
      }
    }]
  }
}
