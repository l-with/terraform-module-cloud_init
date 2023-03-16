locals {
  cloud_init_comment_fail2ban        = ["# fail2ban"]
  cloud_init_package_fail2ban_prefix = "${path.module}/templates/fail2ban/cloudinit.yml.packages"

  cloud_init_package_fail2ban = join(
    "\n",
    local.cloud_init_comment_fail2ban,
    [
      templatefile("${local.cloud_init_package_fail2ban_prefix}.tpl", {})
    ]
  )
}

locals {
  cloud_init_write_files_fail2ban_prefix = "${path.module}/templates/fail2ban/cloudinit.yml.write_files"

  cloud_init_write_files_fail2ban_sshd     = var.fail2ban_sshd ? [templatefile("${local.cloud_init_write_files_fail2ban_prefix}_jail.tpl", { jail = "sshd" })] : []
  cloud_init_write_files_fail2ban_recidive = var.fail2ban_recidive ? [templatefile("${local.cloud_init_write_files_fail2ban_prefix}_jail.tpl", { jail = "recidive" })] : []

  cloud_init_write_files_fail2ban = join(
    "\n",
    concat(
      local.cloud_init_comment_fail2ban,
      [
        templatefile("${local.cloud_init_write_files_fail2ban_prefix}_jail_local.tpl", {})
      ],
      local.cloud_init_write_files_fail2ban_sshd,
      local.cloud_init_write_files_fail2ban_recidive
    )
  )
}

locals {
  cloud_init_runcmd_fail2ban_prefix = "${path.module}/templates/fail2ban/cloudinit.yml.runcmd"

  cloud_init_runcmd_fail2ban = join(
    "\n",
    local.cloud_init_comment_fail2ban,
    [
      templatefile("${local.cloud_init_runcmd_fail2ban_prefix}.tpl", {})
    ]
  )
}
