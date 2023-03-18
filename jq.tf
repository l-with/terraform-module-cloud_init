module "jq" {
  count = local.parts_active["jq"] ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "jq"
  packages = [{
    template = "${path.module}/templates/jq/${local.yml_packages}.tpl",
    vars     = {}
  }]
}
