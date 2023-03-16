locals {
  vault = var.vault || var.rke2_node_1st
}

locals {
  cloud_init_comment_vault        = ["# vault"]
  cloud_init_package_vault_prefix = "${path.module}/templates/vault/cloudinit.yml.packages"

  cloud_init_package_vault = join(
    "\n",
    local.cloud_init_comment_vault,
    [
      templatefile("${local.cloud_init_package_vault_prefix}.tpl", {})
    ]
  )
}


locals {
  cloud_init_runcmd_vault_prefix = "${path.module}/templates/vault/cloudinit.yml.runcmd"

  cloud_init_runcmd_vault = join(
    "\n",
    local.cloud_init_comment_vault,
    [
      templatefile("${local.cloud_init_runcmd_vault_prefix}.tpl", {})
    ]
  )
}
