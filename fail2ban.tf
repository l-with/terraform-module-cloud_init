locals {
  cloud_init_fail2ban_comment        = ["# fail2ban"]
  cloud_init_fail2ban_package_prefix = "${path.module}/templates/fail2ban/cloudinit.yml.packages"

  cloud_init_fail2ban_package = join(
    "\n",
    local.cloud_init_fail2ban_comment,
    [
      templatefile("${local.cloud_init_fail2ban_package_prefix}.tpl", {})
    ]
  )
}

locals {
  cloud_init_fail2ban_write_files_prefix = "${path.module}/templates/fail2ban/cloudinit.yml.write_files"

  cloud_init_fail2ban_write_files_sshd     = var.fail2ban_sshd ? [templatefile("${local.cloud_init_fail2ban_write_files_prefix}_jail.tpl", { jail = "sshd" })] : []
  cloud_init_fail2ban_write_files_recidive = var.fail2ban_recidive ? [templatefile("${local.cloud_init_fail2ban_write_files_prefix}_jail.tpl", { jail = "recidive" })] : []

  cloud_init_fail2ban_write_files = join(
    "\n",
    concat(
      local.cloud_init_fail2ban_comment,
      [
        templatefile("${local.cloud_init_fail2ban_write_files_prefix}_jail_local.tpl", {})
      ],
      local.cloud_init_fail2ban_write_files_sshd,
      local.cloud_init_fail2ban_write_files_recidive
    )
  )
}

locals {
  cloud_init_fail2ban_runcmd_prefix = "${path.module}/templates/fail2ban/cloudinit.yml.runcmd"

  cloud_init_fail2ban_runcmd = join(
    "\n",
    local.cloud_init_fail2ban_comment,
    [
      templatefile("${local.cloud_init_fail2ban_runcmd_prefix}.tpl", {})
    ]
  )
}
