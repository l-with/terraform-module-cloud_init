locals {
  cloud_init_docker_comment            = ["# docker"]
  cloud_init_docker_write_files_prefix = "${path.module}/templates/docker/cloudinit.yml.write_files"

  cloud_init_docker_write_files_daemon_json = var.docker_manipulate_iptables ? [] : [templatefile("${local.cloud_init_docker_write_files_prefix}_daemon_json.tpl", {})]

  cloud_init_docker_write_files = join(
    "\n",
    local.cloud_init_docker_comment,
    local.cloud_init_docker_write_files_daemon_json
  )
}

locals {
  cloud_init_docker_runcmd_prefix = "${path.module}/templates/docker/cloudinit.yml.runcmd"

  cloud_init_docker_runcmd = join(
    "\n",
    local.cloud_init_docker_comment,
    [
      templatefile("${local.cloud_init_docker_runcmd_prefix}.tpl", {})
    ]
  )
}
