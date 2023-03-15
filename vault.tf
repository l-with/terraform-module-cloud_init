locals {
  vault = var.vault || var.rke2_node_1st
}

locals {
  cloud_init_vault_comment        = ["# vault"]
  cloud_init_vault_package_prefix = "${path.module}/templates/vault/cloudinit.yml.packages"

  cloud_init_vault_package = join(
    "\n",
    local.cloud_init_vault_comment,
    [
      templatefile("${local.cloud_init_vault_package_prefix}.tpl", {})
    ]
  )
}


locals {
  cloud_init_vault_runcmd_prefix = "${path.module}/templates/vault/cloudinit.yml.runcmd"

  cloud_init_vault_runcmd = join(
    "\n",
    local.cloud_init_vault_comment,
    [
      templatefile("${local.cloud_init_vault_runcmd_prefix}.tpl", {})
    ]
  )
}
