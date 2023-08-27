locals {
  hetzner = !local.parts_active.hetzner ? {} : {
    runcmd = !var.hetzner_remove_fqdn_resolve ? [] : [{
      template = "${path.module}/templates/hetzner/${local.yml_runcmd}_remove_fqdn_resolve.tpl",
      vars     = {}
    }]
  }
}
