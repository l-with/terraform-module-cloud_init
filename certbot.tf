module "certbot" {
  count = local.parts_active["certbot"] ? 1 : 0

  source = "./modules/cloud_init_part"

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
