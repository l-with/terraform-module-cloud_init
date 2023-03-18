module "vault" {
  count = local.vault ? 1 : 0

  source = "./modules/cloud_init_parts"

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
