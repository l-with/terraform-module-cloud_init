module "vault" {
  count = local.parts_active["vault"] ? 1 : 0

  source = "./modules/cloud_init_part"

  part = "vault"
  packages = [{
    template = "${path.module}/templates/vault/${local.yml_packages}.tpl",
    vars     = {}
  }]
  runcmd = [{
    template = "${path.module}/templates/vault/${local.yml_runcmd}.tpl",
    vars     = {}
  }]
}
