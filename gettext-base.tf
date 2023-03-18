module "gettext_base" {
  count = local.parts_active["gettext_base"] ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "gettext-base"
  packages = [{
    template = "${path.module}/templates/gettext-base/${local.yml_packages}.tpl",
    vars     = {}
  }]
}
