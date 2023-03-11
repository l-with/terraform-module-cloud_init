locals {
  cloud_init_jq_package_prefix = "${path.module}/templates/jq/cloudinit.yml.packages"

  cloud_init_jq_package = join(
    "\n",
    [
      templatefile("${local.cloud_init_jq_package_prefix}.tpl", {})
    ]
  )
}
