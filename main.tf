locals {
  parts_active = {
    b2                 = var.b2,
    certbot            = var.certbot,
    croc               = var.croc,
    docker             = var.docker || var.docker_container || var.mailcow,
    docker_container   = var.docker_container,
    encrypted_packages = var.encrypted_packages,
    fail2ban           = var.fail2ban,
    gettext_base       = var.gettext_base || var.rke2_node_1st || var.rke2_node_other,
    jq                 = var.jq || (var.vault && var.vault_start && var.vault_init),
    mailcow            = var.mailcow,
    lineinfile         = var.lineinfile || var.mailcow,
    terraform          = var.terraform,
    haproxy            = var.haproxy,
    lnxrouter          = var.lnxrouter,
    network            = var.network,
    nginx              = var.nginx,
    packages           = var.packages != []
    python3_pip        = var.python3_pip || var.s3cmd,
    rke2_node_1st      = var.rke2 && var.rke2_node_1st,
    rke2_node_other    = var.rke2 && var.rke2_node_other,
    runcmd             = var.runcmd,
    s3cmd              = var.s3cmd,
    vault              = var.vault || var.rke2_node_1st,
    wait_until         = var.wait_until || var.mailcow || var.rke2_node_1st || (var.vault && var.vault_start && var.vault_init),
    write_file         = var.write_file
  }
}

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
    b2                 = local.b2,
    certbot            = local.certbot,
    croc               = local.croc,
    docker             = local.docker,
    docker_container   = local.docker_container,
    encrypted_packages = local.encrypted_packages,
    fail2ban           = local.fail2ban,
    gettext_base       = local.gettext_base,
    haproxy            = local.haproxy,
    jq                 = local.jq,
    mailcow            = local.mailcow,
    lineinfile         = local.lineinfile,
    lnxrouter          = local.lnxrouter,
    network            = local.network,
    nginx              = local.nginx,
    packages           = local.packages,
    python3_pip        = local.python3_pip,
    rke2_node_1st      = local.rke2_node_1st,
    rke2_node_other    = local.rke2_node_other,
    runcmd             = local.runcmd,
    s3cmd              = local.s3cmd,
    terraform          = local.terraform,
    vault              = local.vault,
    wait_until         = local.wait_until,
    write_file         = local.write_file,
  }
  active_parts_inputs = {
    for part in keys(local.parts_active) :
    part => merge({ write_files = tolist([]), packages = tolist([]), runcmd = tolist([]) }, local.parts_inputs[part])
  }
  parts_sorted = [
    "packages",
    "write_file",
    "network",
    "croc",
    "docker",
    "docker_container",
    "certbot",
    "encrypted_packages",
    "fail2ban",
    "gettext_base",
    "jq",
    "terraform",
    "python3_pip",
    "s3cmd",
    "wait_until",
    "runcmd",
    "lineinfile",
    "mailcow",
    "haproxy",
    "lnxrouter",
    "nginx",
    "vault",
    "rke2_node_1st",
    "rke2_node_other",
  ]
}

locals {
  cloud_init_packages = join(
    "\n",
    [
      for part in local.parts_sorted :
      module.cloud_init_part[part].packages
      if(local.parts_active[part] && module.cloud_init_part[part].packages != "")
    ],
  )
  cloud_init_write_files = join(
    "\n",
    [
      for part in local.parts_sorted :
      module.cloud_init_part[part].write_files
      if(local.parts_active[part] && module.cloud_init_part[part].write_files != "")
    ],
  )
  cloud_init_runcmd = join(
    "\n",
    [
      for part in local.parts_sorted :
      module.cloud_init_part[part].runcmd
      if(local.parts_active[part] && module.cloud_init_part[part].runcmd != "")
    ],
  )
  cloud_init_start = join(
    "\n",
    concat(
      [
        "#cloud-config",
      ],
      var.comment == null ? [] : var.comments
    )
  )

  cloud_init_package_update             = var.package && var.package_update ? "package_update: true" : ""
  cloud_init_package_upgrade            = var.package && var.package_upgrade ? "package_upgrade: true" : ""
  cloud_init_package_reboot_if_required = var.package && var.package_reboot_if_required ? "package_reboot_if_required: true" : ""
  cloud_init_write_files_start          = "\nwrite_files:"
  cloud_init_packages_start             = "\npackages:"
  cloud_init_runcmd_start               = "\nruncmd:"
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
    ],
  )
}
