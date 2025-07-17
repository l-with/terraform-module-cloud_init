locals {
  xvault_pgp_external_public_keys = var.vault_init_pgp_public_keys == null ? [] : [
    for i, vault_pgp_external_public_key in var.vault_init_pgp_public_keys.pgp_external_public_keys : merge(
      vault_pgp_external_public_key,
      {
        pgp_pub_key = "${var.vault_bootstrap_files_path}/external${i}.pub",
      }
    )
  ]

  users = {
    users = concat(
      [
        for index, user in var.users : {
          template = "${path.module}/templates/${local.yml_users}.tpl",
          vars = {
            name                            = user.name,
            groups                          = user.groups,
            sudo                            = user.sudo,
            jsonencoded_ssh_authorized_keys = jsonencode(user.ssh_authorized_keys),
            passwd                          = user.passwd,
            lock_passwd                     = user.lock_passwd,
            shell                           = user.shell,
          }
        }
      ]
    )
  }
}
