locals {
  fail2ban = !local.parts_active.fail2ban ? {} : {
    packages = [{
      template = "${path.module}/templates/${local.yml_packages}.tpl",
      vars = {
        package = "fail2ban"
      }
    }]
    write_files = concat(
      [
        {
          template = "${path.module}/templates/fail2ban/${local.yml_write_files}_jail_local.tpl",
          vars     = {}
        }
      ],
      var.fail2ban_sshd ? [
        {
          template = "${path.module}/templates/fail2ban/${local.yml_write_files}_jail.tpl",
          vars     = { jail = "sshd" }
        }
      ]
      : [],
      var.fail2ban_recidive ? [
        {
          template = "${path.module}/templates/fail2ban/${local.yml_write_files}_jail.tpl",
          vars     = { jail = "recidive" }
        }
      ]
      : []
    )
    runcmd = [{
      template = "${path.module}/templates/fail2ban/${local.yml_runcmd}_service.tpl",
      vars     = {}
    }]
  }
}
