locals {
  wait_until = var.wait_until || var.rke2_node_1st
}

locals {
  cloud_init_comment_wait_until       = ["# wait_until"]
  cloud_init_runcmd_wait_until_prefix = "${path.module}/templates/wait_until/cloudinit.yml.runcmd"

  cloud_init_runcmd_wait_until = join(
    "\n",
    local.cloud_init_comment_wait_until,
    [
      templatefile("${local.cloud_init_runcmd_wait_until_prefix}.tpl", {})
    ]
  )
}
