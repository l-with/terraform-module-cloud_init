locals {
  gettext_base = var.gettext_base || var.rke2_node_1st || var.rke2_node_other
}

locals {
  cloud_init_comment_gettext_base         = ["# gettext-base"]
  cloud_init_packages_gettext_base_prefix = "${path.module}/templates/gettext-base/cloudinit.yml.packages"

  cloud_init_packages_gettext_base = join(
    "\n",
    local.cloud_init_comment_gettext_base,
    [
      templatefile("${local.cloud_init_packages_gettext_base_prefix}.tpl", {})
    ]
  )
}
