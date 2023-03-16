locals {
  cloud_init_comment_certbot        = ["# certbot"]
  cloud_init_package_certbot_prefix = "${path.module}/templates/certbot/cloudinit.yml.packages"

  cloud_init_package_certbot = join(
    "\n",
    local.cloud_init_comment_certbot,
    compact([
      templatefile("${local.cloud_init_package_certbot_prefix}.tpl", {}),
      var.certbot_dns_hetzner ? templatefile("${local.cloud_init_package_certbot_prefix}_certbot_dns_hetzner.tpl", {}) : ""
    ])
  )
}

locals {
  cloud_init_runcmd_certbot_prefix = "${path.module}/templates/certbot/cloudinit.yml.runcmd"

  cloud_init_runcmd_certbot = join(
    "\n",
    local.cloud_init_comment_certbot,
    compact([
      var.certbot_dns_hetzner ? templatefile("${local.cloud_init_runcmd_certbot_prefix}.tpl", {}) : ""
    ])
  )
}
