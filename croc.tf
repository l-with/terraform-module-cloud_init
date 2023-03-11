locals {
  cloud_init_croc_runcmd_prefix = "${path.module}/templates/croc/cloudinit.yml.runcmd"

  cloud_init_croc_runcmd = join(
    "\n",
    [
      templatefile("${local.cloud_init_croc_runcmd_prefix}.tpl", {})
    ]
  )
}
