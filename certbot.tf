module "certbot" {
  count = local.parts_active["certbot"] ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "certbot"
  packages = concat(
    [
      {
        template = "${path.module}/templates/certbot/${local.yml_packages}.tpl",
        vars     = {}
      }
    ],
    var.certbot_dns_hetzner ? [
      {
        template = "${path.module}/templates/certbot/${local.yml_packages}_certbot_dns_hetzner.tpl",
        vars     = {}
      }
    ]
    : []
  )
  runcmd = var.certbot_dns_hetzner ? [{
    template = "${path.module}/templates/certbot/${local.yml_runcmd}.tpl",
    vars     = {}
  }] : []
}

/*
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
*/