locals {
  cloud_init_comment_docker            = ["# docker"]
  cloud_init_write_files_docker_prefix = "${path.module}/templates/docker/cloudinit.yml.write_files"

  cloud_init_write_files_docker_daemon_json = var.docker_manipulate_iptables ? [] : [templatefile("${local.cloud_init_write_files_docker_prefix}_daemon_json.tpl", {})]

  cloud_init_docker_write_files = join(
    "\n",
    local.cloud_init_comment_docker,
    local.cloud_init_write_files_docker_daemon_json
  )
}

locals {
  cloud_init_runcmd_docker_prefix = "${path.module}/templates/docker/cloudinit.yml.runcmd"

  cloud_init_runcmd_docker = join(
    "\n",
    local.cloud_init_comment_docker,
    [
      templatefile("${local.cloud_init_runcmd_docker_prefix}.tpl", {})
    ]
  )
}
