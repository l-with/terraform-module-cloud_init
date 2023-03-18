module "wait_until" {
  count = var.wait_until ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "wait_until"
  runcmd = [{
    template = "${path.module}/templates/wait_until/${local.yml_runcmd}.tpl",
    vars     = {}
  }]
}

/*
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
*/
