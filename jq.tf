locals {
  cloud_comment_init_jq        = ["# jq"]
  cloud_init_package_jq_prefix = "${path.module}/templates/jq/cloudinit.yml.packages"

  cloud_init_package_jq = join(
    "\n",
    local.cloud_init_comment_fail2ban,
    [
      templatefile("${local.cloud_init_package_jq_prefix}.tpl", {})
    ]
  )
}
