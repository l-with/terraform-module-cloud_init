locals {
  docker_service_file_full_path = "/etc/systemd/system/docker.service"
  docker_socket_file_full_path  = "/etc/systemd/system/docker.socket"

  docker = !local.parts_active.docker ? {} : {
    runcmd = concat(
      [
        {
          template = "${path.module}/templates/docker/${local.yml_runcmd}_${var.docker_install_method}_install.tpl",
          vars = {
            docker_version = var.docker_version, // ignored for docker_install_method 'apt'
          }
        },
      ],
      !(var.docker_install_method == "binary") ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
          vars = {
            runcmd_script = "  # systemd service, socket"
          }
        },
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(local.docker_service_file_full_path),
            write_file_name      = basename(local.docker_service_file_full_path),
            write_file_content   = templatefile("${path.module}/templates/docker/docker.service.tpl", {}),
            write_file_owner     = "root",
            write_file_group     = "root",
            write_file_mode      = 644,
          }
        },
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(local.docker_socket_file_full_path),
            write_file_name      = basename(local.docker_socket_file_full_path),
            write_file_content   = templatefile("${path.module}/templates/docker/docker.socket.tpl", {}),
            write_file_owner     = "root",
            write_file_group     = "root",
            write_file_mode      = 644,
          }
        },
      ],
      !(!var.docker_manipulate_iptables || var.docker_registry_mirror != null) ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(var.docker_daemon_json_full_path),
            write_file_name      = basename(var.docker_daemon_json_full_path),
            write_file_content = templatefile("${path.module}/templates/docker/daemon.json.tpl", {
              docker_manipulate_iptables = var.docker_manipulate_iptables,
              docker_registry_mirror     = var.docker_registry_mirror,
              docker_insecure_registry   = startswith(var.docker_registry_mirror, "https://") ? null : trimprefix(var.docker_registry_mirror, "http://"),
            }),
            write_file_owner = "root",
            write_file_group = "root",
            write_file_mode  = 644,
          }
        },
      ]
    )
  }
}
