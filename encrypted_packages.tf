locals {
  cloud_init_comment_encrypted_packages       = ["# encrypted_packages"]
  cloud_init_runcmd_encrypted_packages_prefix = "${path.module}/templates/encrypted_packages/cloudinit.yml.runcmd"

  cloud_init_runcmd_encrypted_packages = join(
    "\n",
    local.cloud_init_comment_encrypted_packages,
    [
      for package in var.encrypted_packages :
      templatefile(
        "${local.cloud_init_runcmd_encrypted_packages_prefix}.tpl",
        {
          url        = package.url
          api_header = package.api_header
          secret     = package.secret
          post_cmd   = package.post_cmd
        }
      )
    ]
  )
}