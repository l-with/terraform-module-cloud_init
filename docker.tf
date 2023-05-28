locals {
  docker = !local.parts_active.docker ? {} : {
    runcmd = [{
      template = "${path.module}/templates/docker/${local.yml_runcmd}_install.tpl",
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
}
