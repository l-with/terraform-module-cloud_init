locals {
  cloud_init_certbot_comment        = ["# certbot"]
  cloud_init_certbot_package_prefix = "${path.module}/templates/certbot/cloudinit.yml.packages"

  cloud_init_certbot_package = join(
    "\n",
    local.cloud_init_certbot_comment,
    compact([
      templatefile("${local.cloud_init_certbot_package_prefix}.tpl", {}),
      var.certbot_dns_hetzner ? templatefile("${local.cloud_init_certbot_package_prefix}_certbot_dns_hetzner.tpl", {}) : ""
    ])
  )
}

locals {
  cloud_init_certbot_runcmd_prefix = "${path.module}/templates/certbot/cloudinit.yml.runcmd"

  cloud_init_certbot_runcmd = join(
    "\n",
    local.cloud_init_certbot_comment,
    compact([
      var.certbot_dns_hetzner ? templatefile("${local.cloud_init_certbot_runcmd_prefix}.tpl", {}) : ""
    ])
  )
}
