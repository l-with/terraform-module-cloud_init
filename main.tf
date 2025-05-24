locals {
  python3_pip_modules = concat(
    var.python3_pip_modules,
    !local.parts_active.certbot ? [] : var.certbot_dns_plugins,
  )
  parts_active = {
    b2                 = var.b2,
    certbot            = var.certbot,
    croc               = var.croc,
    containerd         = var.containerd || (var.docker && var.docker_install_method == "binary"),
    digitalocean       = var.digitalocean,
    docker             = var.docker || var.docker_container || var.mailcow,
    docker_container   = var.docker_container,
    duplicacy          = var.duplicacy,
    encrypted_packages = var.encrypted_packages,
    fail2ban           = var.fail2ban,
    gettext_base       = var.gettext_base,
    hetzner            = var.hetzner,
    jq = (
      var.jq || (
        var.vault && var.vault_start && (
          var.vault_init || var.vault_unseal || var.vault_revoke_root_token
        )
    )),
    golang          = var.golang || var.vault_raft_retry_autojoin != null,
    gpg             = var.gpg,
    netcat          = var.netcat,
    mailcow         = var.mailcow,
    lineinfile      = var.lineinfile || var.mailcow || (var.hetzner && var.hetzner_remove_fqdn_resolve) || var.sshd_config,
    sshd_config     = var.sshd_config,
    terraform       = var.terraform,
    haproxy         = var.haproxy,
    lnxrouter       = var.lnxrouter,
    network         = var.network,
    nginx           = var.nginx,
    packages        = var.package,
    python3_pip     = var.python3_pip || var.s3cmd || var.certbot,
    rke2_node_1st   = var.rke2 && var.rke2_node_1st,
    rke2_node_other = var.rke2 && var.rke2_node_other,
    runcmd          = var.runcmd,
    tool            = var.tool,
    unzip           = var.unzip || (var.vault && var.vault_install_method == "binary")
    s3cmd           = var.s3cmd,
    vault           = var.vault || var.rke2_node_1st,
    wait_until = (
      var.wait_until || var.mailcow || var.rke2_node_1st || (
        var.vault && var.vault_start && (
          var.vault_init || var.vault_unseal || var.vault_spread_vault_init_json || var.vault_receive_vault_init_json
        )
      )
    ),
    write_file = var.write_file
    user       = var.user
    zypper     = var.zypper
  }
}

module "cloud_init_part" {
  for_each = local.active_parts_inputs

  source = "./modules/cloud_init_part"

  part        = each.key
  write_files = each.value.write_files
  users       = each.value.users
  runcmd      = each.value.runcmd
  packages    = each.value.packages
}

locals {
  parts_inputs = {
    b2                 = local.b2,
    certbot            = local.certbot,
    croc               = local.croc,
    containerd         = local.containerd,
    digitalocean       = local.digitalocean,
    docker             = local.docker,
    docker_container   = local.docker_container,
    duplicacy          = local.duplicacy,
    encrypted_packages = local.encrypted_packages,
    fail2ban           = local.fail2ban,
    gettext_base       = local.gettext_base,
    haproxy            = local.haproxy,
    hetzner            = local.hetzner,
    jq                 = local.jq,
    golang             = local.golang,
    gpg                = local.gpg,
    mailcow            = local.mailcow,
    lineinfile         = local.lineinfile,
    lnxrouter          = local.lnxrouter,
    netcat             = local.netcat,
    network            = local.network,
    nginx              = local.nginx,
    packages           = local.packages,
    python3_pip        = local.python3_pip,
    rke2_node_1st      = local.rke2_node_1st,
    rke2_node_other    = local.rke2_node_other,
    runcmd             = local.runcmd,
    s3cmd              = local.s3cmd,
    sshd_config        = local.sshd_config,
    terraform          = local.terraform,
    tool               = local.tool,
    user               = local.users,
    unzip              = local.unzip,
    vault              = local.vault,
    wait_until         = local.wait_until,
    write_file         = local.write_file,
    zypper             = local.zypper,
  }
  active_parts_inputs = {
    for part in keys(local.parts_active) :
    part => merge({ write_files = tolist([]), users = tolist([]), packages = tolist([]), runcmd = tolist([]) }, local.parts_inputs[part])
  }
  parts_sorted = [
    "lineinfile",
    "hetzner",
    "digitalocean",
    "packages",
    "zypper",
    "unzip",
    "write_file",
    "tool",
    "user",
    "sshd_config",
    "netcat",
    "network",
    "croc",
    "containerd",
    "docker",
    "docker_container",
    "certbot",
    "encrypted_packages",
    "fail2ban",
    "gettext_base",
    "jq",
    "golang",
    "gpg",
    "terraform",
    "python3_pip",
    "s3cmd",
    "wait_until",
    "runcmd",
    "mailcow",
    "duplicacy",
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
  cloud_init_users = join(
    "\n",
    [
      for part in local.parts_sorted :
      module.cloud_init_part[part].users
      if(local.parts_active[part] && module.cloud_init_part[part].users != "")
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
  cloud_init_hostname                   = var.hostname_fqdn && var.hostname != null ? "hostname: ${var.hostname}" : ""
  cloud_init_fqdn                       = var.hostname_fqdn && var.fqdn != null ? "fqdn: ${var.fqdn}" : ""
  cloud_init_create_hostname_file       = var.hostname_fqdn && var.create_hostname_file != null ? "create_hostname_file: ${var.create_hostname_file}" : ""
  cloud_init_prefer_fqdn_over_hostname  = var.prefer_fqdn_over_hostname && var.prefer_fqdn_over_hostname != null ? "prefer_fqdn_over_hostname: ${var.prefer_fqdn_over_hostname}" : ""
  cloud_init_package_update             = var.package && var.package_update ? "package_update: true" : ""
  cloud_init_package_upgrade            = var.package && var.package_upgrade ? "package_upgrade: true" : ""
  cloud_init_package_reboot_if_required = var.package && var.package_reboot_if_required ? "package_reboot_if_required: true" : ""
  cloud_init_write_files_start          = "\nwrite_files:"
  cloud_init_packages_start             = "\npackages:"
  cloud_init_users_start                = "\nusers:"
  cloud_init_runcmd_start               = "\nruncmd:"
  cloud_init_runcmd_end = templatefile(
    "${path.module}/templates/${local.yml_runcmd}_end.tpl",
    {
      runcmd_done_file = var.runcmd_done_file
    }
  )

  cloud_init = join(
    "\n",
    concat(
      [
        local.cloud_init_start,
      ],
      local.cloud_init_hostname == "" ? [] : [
        local.cloud_init_hostname,
      ],
      local.cloud_init_fqdn == "" ? [] : [
        local.cloud_init_fqdn,
      ],
      local.cloud_init_create_hostname_file == "" ? [] : [
        local.cloud_init_create_hostname_file,
      ],
      local.cloud_init_prefer_fqdn_over_hostname == "" ? [] : [
        local.cloud_init_prefer_fqdn_over_hostname,
      ],
      local.cloud_init_package_update == "" ? [] : [
        local.cloud_init_package_update,
      ],
      local.cloud_init_package_upgrade == "" ? [] : [
        local.cloud_init_package_upgrade,
      ],
      local.cloud_init_package_reboot_if_required == "" ? [] : [
        local.cloud_init_package_reboot_if_required,
      ],
      local.cloud_init_write_files == "" ? [] : [
        local.cloud_init_write_files_start,
        local.cloud_init_write_files,
      ],
      local.cloud_init_users == "" ? [] : [
        local.cloud_init_users_start,
        local.cloud_init_users,
      ],
      local.cloud_init_packages == "" ? [] : [
        local.cloud_init_packages_start,
        local.cloud_init_packages,
      ],
      [
        local.cloud_init_runcmd_start,
      ],
      local.cloud_init_runcmd == "" ? [] : [
        local.cloud_init_runcmd,
      ],
      [
        local.cloud_init_runcmd_end
      ],
    ),
  )
  cloud_init_base64gzip = base64gzip(local.cloud_init)
  cloud_init_base64     = base64encode(local.cloud_init)
}
