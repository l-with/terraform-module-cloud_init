locals {
  gettext_base = var.gettext_base || var.rke2_master_1st || var.rke2_master_other
}

locals {
  cloud_init_gettext_base_packages_prefix = "${path.module}/templates/gettext-base/cloudinit.yml.packages"

  cloud_init_gettext_base_packages = join(
    "\n",
    [
      templatefile("${local.cloud_init_gettext_base_packages_prefix}.tpl", {})
    ]
  )
}
