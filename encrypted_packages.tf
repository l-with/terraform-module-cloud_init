module "encrypted_packages" {
  count = local.parts_active["encrypted_packages"] ? 1 : 0

  source = "./modules/cloud_init_part"

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
