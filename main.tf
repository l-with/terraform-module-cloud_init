module "cloud_init_part" {
  for_each = local.active_parts_inputs

  source = "./modules/cloud_init_part"

  part        = each.key
  packages    = each.value.packages
  write_files = each.value.write_files
  runcmd      = each.value.runcmd
}

locals {
  parts_inputs = {
    certbot            = local.certbot
    croc               = local.croc,
    docker             = local.docker
    encrypted_packages = local.encrypted_packages
    fail2ban           = local.fail2ban
    gettext_base       = local.gettext_base
    jq                 = local.jq
    nginx              = local.nginx
    rke2_node_1st      = local.rke2_node_1st
    rke2_node_other    = local.rke2_node_other
    vault              = local.vault
    wait_until         = local.wait_until
  }
  active_parts_inputs = {
    for part in local.parts_sorted :
    part => merge({ write_files = tolist([]), packages = tolist([]), runcmd = tolist([]) }, local.parts_inputs[part])
    if local.parts_active[part]
  }
  parts_sorted = [
    "croc",
    "docker",
    "encrypted_packages",
    "fail2ban",
    "gettext_base",
    "jq",
    "nginx",
    "certbot",
    "vault",
    "wait_until",
    "rke2_node_1st",
    "rke2_node_other",
  ]
  parts_active = {
    certbot            = var.certbot
    croc               = var.croc
    docker             = var.docker
    encrypted_packages = length(var.encrypted_packages) >= 0
    fail2ban           = var.fail2ban
    gettext_base       = var.gettext_base || var.rke2_node_1st || var.rke2_node_other
    jq                 = var.jq
    nginx              = var.nginx
    rke2_node_1st      = var.rke2 && var.rke2_node_1st
    rke2_node_other    = var.rke2 && var.rke2_node_other
    vault              = var.vault || var.rke2_node_1st
    wait_until         = var.wait_until || var.rke2_node_1st
  }
}

locals {
  cloud_init_packages = join(
    "\n",
    [
      for part in keys(local.active_parts_inputs) :
      module.cloud_init_part[part].packages
      if module.cloud_init_part[part].packages != ""
    ]
  )
  cloud_init_write_files = join(
    "\n",
    [
      for part in keys(local.active_parts_inputs) :
      module.cloud_init_part[part].write_files
      if module.cloud_init_part[part].write_files != ""
    ]
  )
  cloud_init_runcmd = join(
    "\n",
    [
      for part in keys(local.active_parts_inputs) :
      module.cloud_init_part[part].runcmd
      if module.cloud_init_part[part].runcmd != ""
    ]
  )
  cloud_init_start = "#cloud-config"

  cloud_init_package_update             = var.package && var.package_update ? "package_update: true" : ""
  cloud_init_package_upgrade            = var.package && var.package_upgrade ? "package_upgrade: true" : ""
  cloud_init_package_reboot_if_required = var.package && var.package_reboot_if_required ? "package_reboot_if_required: true" : ""
  cloud_init_write_files_start          = "write_files:"
  cloud_init_packages_start             = "packages:"
  cloud_init_runcmd_start               = "runcmd:"
  cloud_init_runcmd_end                 = templatefile("${path.module}/templates/${local.yml_runcmd}_end.tpl", {})

  cloud_init = join(
    "\n",
    [
      local.cloud_init_start,
      local.cloud_init_package_update,
      local.cloud_init_package_upgrade,
      local.cloud_init_package_reboot_if_required,
      local.cloud_init_write_files_start,
      local.cloud_init_write_files,
      local.cloud_init_packages_start,
      local.cloud_init_packages,
      local.cloud_init_runcmd_start,
      local.cloud_init_runcmd,
      local.cloud_init_runcmd_end
    ]
  )
}
