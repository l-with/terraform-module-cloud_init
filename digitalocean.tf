locals {
  digitalocean = !local.parts_active.digitalocean ? {} : {
    runcmd = !var.digitalocean_restart_journald ? [] : [
      {
        template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
        vars = {
          runcmd_script = "  - systemctl restart systemd-journald.service"
        }
      }
    ],
  }
}
