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
    certbot = local.certbot
    croc    = local.croc,
    jq      = local.jq
  }
  active_parts_inputs = {
    for part in local.parts :
    part => merge(
      { packages = [], write_files = [], runcmd = [] },
      local.parts_inputs[part]
    ) if local.parts_active[part]
  }
}

locals {
  parts = [
    "certbot",
    "croc",
    "jq",
  ]
  parts_all = [
    "certbot",
    "croc",
    "docker",
    "encrypted_packages",
    "fail2ban",
    "gettext_base",
    "jq",
    "nginx",
    "rke2_node_1st",
    "rke2_node_other",
    "vault",
    "wait_until",
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
  parts_write_files = [
    for part in local.parts_all : part if local.parts_active[part]
  ]
}

locals {
  cloud_init_runcmd_end_template = "${path.module}/templates/cloudinit.yml.runcmd_end.tpl"
  cloud_init_parts_keys_sorted = [
    "cloud_init_start",
    "cloud_init_package_update",
    "cloud_init_package_upgrade",
    "cloud_init_package_reboot_if_required",
    "cloud_init_write_files",
    "cloud_init_write_files_docker",
    "cloud_init_write_files_fail2ban",
    "cloud_init_write_files_nginx",
    "cloud_init_packages",
    "cloud_init_packages_gettext_base",
    "cloud_init_packages_jq",
    "cloud_init_packages_vault",
    "cloud_init_packages_fail2ban",
    "cloud_init_packages_nginx",
    "cloud_init_packages_certbot",
    "cloud_init_runcmd",
    "cloud_init_runcmd_croc",
    "cloud_init_runcmd_wait_until",
    "cloud_init_runcmd_docker",
    "cloud_init_runcmd_vault",
    "cloud_init_runcmd_fail2ban",
    "cloud_init_runcmd_encryped_packages",
    "cloud_init_runcmd_nginx",
    "cloud_init_runcmd_certbot",
    "cloud_init_runcmd_rke2_node_1st",
    "cloud_init_runcmd_rke2_node_other",
    "cloud_init_runcmd_end"
  ]
  cloud_init_parts = {
    cloud_init_start = "#cloud-config"

    cloud_init_package_update             = var.package && var.package_update ? "package_update: true" : ""
    cloud_init_package_upgrade            = var.package && var.package_upgrade ? "package_upgrade: true" : ""
    cloud_init_package_reboot_if_required = var.package && var.package_reboot_if_required ? "package_reboot_if_required: true" : ""

    cloud_init_write_files = "write_files:"

    cloud_init_write_files_docker   = local.parts_active["docker"] ? module.docker[0].write_files : ""
    cloud_init_write_files_fail2ban = local.parts_active["fail2ban"] ? module.fail2ban[0].write_files : ""
    cloud_init_write_files_nginx    = local.parts_active["nginx"] ? module.nginx[0].write_files : ""

    cloud_init_packages = "packages:"

    cloud_init_packages_gettext_base    = local.parts_active["gettext_base"] ? module.gettext_base[0].packages : ""
    cloud_init_packages_jq              = local.parts_active["jq"] ? module.cloud_init_part["jq"].packages : ""
    cloud_init_packages_vault           = local.parts_active["vault"] ? module.vault[0].packages : ""
    cloud_init_packages_fail2ban        = local.parts_active["fail2ban"] ? module.fail2ban[0].packages : ""
    cloud_init_runcmd_encryped_packages = local.parts_active["encrypted_packages"] ? module.encrypted_packages[0].runcmd : ""
    cloud_init_packages_nginx           = local.parts_active["nginx"] ? module.nginx[0].packages : ""
    cloud_init_packages_certbot         = local.parts_active["certbot"] ? module.cloud_init_part["certbot"].packages : ""

    cloud_init_runcmd = "runcmd:"

    cloud_init_runcmd_croc            = local.parts_active["croc"] ? module.cloud_init_part["croc"].runcmd : ""
    cloud_init_runcmd_wait_until      = local.parts_active["wait_until"] ? module.wait_until[0].runcmd : ""
    cloud_init_runcmd_docker          = local.parts_active["docker"] ? module.docker[0].runcmd : ""
    cloud_init_runcmd_vault           = local.parts_active["vault"] ? module.vault[0].runcmd : ""
    cloud_init_runcmd_certbot         = local.parts_active["certbot"] ? module.cloud_init_part["certbot"].runcmd : ""
    cloud_init_runcmd_fail2ban        = local.parts_active["fail2ban"] ? module.fail2ban[0].runcmd : ""
    cloud_init_runcmd_nginx           = local.parts_active["nginx"] ? module.nginx[0].runcmd : ""
    cloud_init_runcmd_rke2_node_1st   = local.parts_active["rke2_node_1st"] ? module.rke2_node_1st[0].runcmd : ""
    cloud_init_runcmd_rke2_node_other = local.parts_active["rke2_node_other"] ? module.rke2_node_other[0].runcmd : ""
    cloud_init_runcmd_end             = templatefile(local.cloud_init_runcmd_end_template, {}),
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
