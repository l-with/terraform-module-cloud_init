module "wait_until" {
  count = local.parts_active["wait_until"] ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "wait_until"
  runcmd = [{
    template = "${path.module}/templates/wait_until/${local.yml_runcmd}.tpl",
    vars     = {}
  }]
}
