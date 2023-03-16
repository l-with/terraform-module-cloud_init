locals {
  cloud_init_comment_croc       = ["# croc"]
  cloud_init_runcmd_croc_prefix = "${path.module}/templates/croc/cloudinit.yml.runcmd"

  cloud_init_runcmd_croc = join(
    "\n",
    local.cloud_init_comment_croc,
    [
      templatefile("${local.cloud_init_runcmd_croc_prefix}.tpl", {})
    ]
  )
}
