locals {
  containerd_service_file_full_path = "/etc/systemd/system/containerd.service"

  containerd = !local.parts_active.containerd ? {} : {
    runcmd = concat(
      [
        {
          template = "${path.module}/templates/containerd/${local.yml_runcmd}_${var.containerd_install_method}_install.tpl",
          vars = {
            containerd_version = var.containerd_version, // ignored for containerd_install_method 'apt'
          }
        },
      ],
      !(var.containerd_install_method == "binary") ? [] : [
        {
          template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
          vars = {
            runcmd_script = "  # systemd service"
          }
        },
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname(local.containerd_service_file_full_path),
            write_file_name      = basename(local.containerd_service_file_full_path),
            write_file_content   = templatefile("${path.module}/templates/containerd/containerd.service.tpl", {}),
            write_file_owner     = "root",
            write_file_group     = "root",
            write_file_mode      = 644,
          }
        },
        {
          template = "${path.module}/templates/containerd/${local.yml_runcmd}_service.tpl",
          vars     = {}
        },
      ]
    )
  }
}
