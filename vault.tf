locals {
  vault = var.vault || var.rke2_master_1st
}

locals {
  cloud_init_vault_package_prefix = "${path.module}/templates/vault/cloudinit.yml.packages"

  cloud_init_vault_package = join(
    "\n",
    [
      templatefile("${local.cloud_init_vault_package_prefix}.tpl", {})
    ]
  )
}


locals {
  cloud_init_vault_runcmd_prefix = "${path.module}/templates/vault/cloudinit.yml.runcmd"

  cloud_init_vault_runcmd = join(
    "\n",
    [
      templatefile("${local.cloud_init_vault_runcmd_prefix}.tpl", {})
    ]
  )
}
