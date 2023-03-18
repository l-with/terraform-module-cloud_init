module "docker" {
  count = local.parts_active["docker"] ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "docker"
  runcmd = [{
    template = "${path.module}/templates/docker/${local.yml_runcmd}.tpl",
    vars     = {}
  }]
  write_files = concat(
    var.docker_manipulate_iptables ? [] : [
      {
        template = "${path.module}/templates/docker/${local.yml_write_files}_daemon_json.tpl",
        vars     = {}
      }
    ],
  )
}
