locals {
  encrypted_packages = length(var.encrypted_packages) >= 0
}

module "encrypted_packages" {
  count = local.encrypted_packages ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "encrypted_packages"
  runcmd = [
    for package in var.encrypted_packages :
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
