locals {
  cloud_init_jq_comment        = ["# jq"]
  cloud_init_jq_package_prefix = "${path.module}/templates/jq/cloudinit.yml.packages"

  cloud_init_jq_package = join(
    "\n",
    local.cloud_init_fail2ban_comment,
    [
      templatefile("${local.cloud_init_jq_package_prefix}.tpl", {})
    ]
  )
}
