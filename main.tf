locals {
  cloud_init_parts_keys_sorted = [
    "cloud_init_start",
    "cloud_init_write_files",
    "cloud_init_write_files_docker",
    "cloud_init_write_files_fail2ban",
    "cloud_init_packages",
    "cloud_init_packages_gettext_base",
    "cloud_init_packages_jq",
    "cloud_init_packages_fail2ban",
    "cloud_init_runcmd",
    "cloud_init_runcmd_croc",
    "cloud_init_runcmd_docker",
    "cloud_init_runcmd_vault",
    "cloud_init_runcmd_fail2ban",
    "cloud_init_runcmd_rke2_master_1st",
    "cloud_init_runcmd_rke2_master_other"
  ]
  cloud_init_parts = {
    cloud_init_start                    = "#cloud-config"
    cloud_init_write_files              = "write_files:"
    cloud_init_write_files_docker       = local.cloud_init_docker_write_files
    cloud_init_write_files_fail2ban     = var.fail2ban ? local.cloud_init_fail2ban_write_files : ""
    cloud_init_packages                 = "packages:"
    cloud_init_packages_gettext_base    = local.gettext_base ? local.cloud_init_gettext_base_packages : ""
    cloud_init_packages_jq              = var.jq ? local.cloud_init_jq_package : ""
    cloud_init_packages_fail2ban        = var.fail2ban ? local.cloud_init_fail2ban_package : ""
    cloud_init_runcmd                   = "runcmd:"
    cloud_init_runcmd_croc              = var.croc ? local.cloud_init_croc_runcmd : ""
    cloud_init_runcmd_docker            = var.docker ? local.cloud_init_docker_runcmd : ""
    cloud_init_runcmd_vault             = local.vault ? local.cloud_init_vault_runcmd : ""
    cloud_init_runcmd_fail2ban          = var.fail2ban ? local.cloud_init_fail2ban_runcmd : ""
    cloud_init_runcmd_rke2_master_1st   = var.rke2_master_1st ? local.cloud_init_runcmd_rke2_master_1st : ""
    cloud_init_runcmd_rke2_master_other = var.rke2_master_other ? local.cloud_init_runcmd_rke2_master_other : ""
  }
  cloud_init_parts_sorted = [
    for key in local.cloud_init_parts_keys_sorted : local.cloud_init_parts[key]
  ]
}

locals {
  cloud_init = join(
    "\n",
    [
      for key in local.cloud_init_parts_keys_sorted :
      local.cloud_init_parts[key] if local.cloud_init_parts[key] != ""
    ]
  )
}
