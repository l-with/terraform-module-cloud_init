module "fail2ban" {
  count = local.parts_active["fail2ban"] ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "fail2ban"
  packages = [{
    template = "${path.module}/templates/fail2ban/${local.yml_packages}.tpl",
    vars     = {}
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
    template = "${path.module}/templates/fail2ban/${local.yml_runcmd}.tpl",
    vars     = {}
  }]
}
