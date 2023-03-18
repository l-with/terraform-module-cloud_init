module "croc" {
  count = local.parts_active["croc"] ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "croc"
  runcmd = [{
    template = "${path.module}/templates/croc/${local.yml_runcmd}.tpl",
    vars     = {}
  }]
}
