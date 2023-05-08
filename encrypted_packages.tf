locals {
  encrypted_packages = !var.encrypted_packages ? {} : {
    runcmd = [
      for package in var.encrypted_packages_list :
      {
        template = "${path.module}/templates/encrypted_packages/${local.yml_runcmd}.tpl",
        vars = {
          url        = package.url
          api_header = package.api_header
          secret     = package.secret
          post_cmd   = package.post_cmd
        }
      }
    ]
  }
}
