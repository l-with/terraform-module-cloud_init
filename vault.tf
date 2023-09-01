locals {
  vault_binary_paths = {
    apt    = "/usr/bin",
    binary = "/usr/local/bin"
  }
  vault_init_public_key_full_path      = "${var.vault_bootstrap_files_path}/vault_init_public.key"
  vault_init_json_pub_full_path        = "${var.vault_bootstrap_files_path}/vault_init_pub.json"
  vault_init_json_enc_full_path        = "${var.vault_bootstrap_files_path}/vault_init_json.tgz.enc"
  vault_init_json_full_path            = "${var.vault_bootstrap_files_path}/vault_init.json"
  vault_init_json_enc_base64_full_path = "${local.vault_init_json_enc_full_path}.base64"
  vault_init_needed_packages = [
    "openssl",
  ]
  vault_init_with_pgp_keys       = (var.vault_init_pgp_public_keys == null ? false : true)
  vault_num_internal_unseal_keys = var.vault_init_pgp_public_keys == null ? 0 : var.vault_init_pgp_public_keys.num_internal_unseal_keys
  vault_pgp_pub_keys = [
    for i in range(local.vault_num_internal_unseal_keys) :
    "${var.vault_bootstrap_files_path}/vault${i}.pub"
  ]
  vault_pgp_priv_keys = [
    for i in range(local.vault_num_internal_unseal_keys) :
    "${var.vault_bootstrap_files_path}/vault${i}"
  ]

  vault_cluster_addr = var.vault_cluster_addr != null ? var.vault_cluster_addr : ""
  vault_tls_storage_raft_leader_ca_cert_file = (
    var.vault_tls_storage_raft_leader_ca_cert_file != null
    ? var.vault_tls_storage_raft_leader_ca_cert_file
    : "${var.vault_home_path}/tls/client_ca.pem"
  )
  vault_tls_storage_raft_leader_client_cert_file = (
    var.vault_tls_storage_raft_leader_client_cert_file != null
    ? var.vault_tls_storage_raft_leader_client_cert_file
    : "${var.vault_home_path}/tls/cert.pem"
  )
  vault_tls_storage_raft_leader_client_key_file = (
    var.vault_tls_storage_raft_leader_client_key_file != null
    ? var.vault_tls_storage_raft_leader_client_key_file
    : "${var.vault_home_path}/tls/key.pem"
  )
  vault_raft_leader_tls_servername = var.vault_raft_leader_tls_servername != null ? var.vault_raft_leader_tls_servername : ""
  vault_tls_client_ca_file         = var.vault_tls_client_ca_file != null ? var.vault_tls_client_ca_file : local.vault_tls_storage_raft_leader_ca_cert_file
  vault_tls_cert_file              = var.vault_tls_cert_file != null ? var.vault_tls_cert_file : local.vault_tls_storage_raft_leader_client_cert_file
  vault_tls_key_file               = var.vault_tls_key_file != null ? var.vault_tls_key_file : local.vault_tls_storage_raft_leader_client_key_file
  vault_tls_files = [
    for vault_tls_file in var.vault_tls_files : {
      file_name = replace(
        replace(
          replace(
            vault_tls_file.file_name,
            "$vault_tls_cert_file",
            var.vault_tls_cert_file == null ? "" : var.vault_tls_cert_file
          ),
          "$vault_tls_key_file",
          var.vault_tls_key_file == null ? "" : var.vault_tls_key_file
        ),
        "$vault_tls_client_ca_file",
        var.vault_tls_client_ca_file == null ? "" : var.vault_tls_client_ca_file
      )
      content  = vault_tls_file.content,
      encoding = vault_tls_file.encoding,
      owner    = vault_tls_file.owner,
      group    = vault_tls_file.group,
      mode     = vault_tls_file.mode,
    }
  ]
  vault_tls_content_file_names = {
    "cert"                            = local.vault_tls_cert_file,
    "key"                             = local.vault_tls_key_file,
    "client_ca"                       = local.vault_tls_client_ca_file,
    "storage_raft_leader_ca_cert"     = local.vault_tls_storage_raft_leader_ca_cert_file,
    "storage_raft_leader_client_cert" = local.vault_tls_storage_raft_leader_client_cert_file,
    "storage_raft_leader_client_key"  = local.vault_tls_storage_raft_leader_client_key_file,
  }
  vault_tls_contents = [
    for vault_tls_content in var.vault_tls_contents : {
      file_name = local.vault_tls_content_file_names[vault_tls_content.tls_file],
      content   = vault_tls_content.content,
      encoding  = vault_tls_content.encoding,
      owner     = vault_tls_content.owner,
      group     = vault_tls_content.group,
      mode      = vault_tls_content.mode,
    }
  ]
  vault_listeners = [
    for listener in var.vault_listeners : {
      address            = listener.address,
      cluster_address    = listener.cluster_address,
      tls_disable        = listener.tls_disable,
      tls_cert_file      = listener.tls_cert_file != null ? listener.tls_cert_file : local.vault_tls_cert_file,
      tls_key_file       = listener.tls_key_file != null ? listener.tls_key_file : local.vault_tls_key_file,
      tls_client_ca_file = listener.tls_client_ca_file != null ? listener.tls_client_ca_file : local.vault_tls_client_ca_file,
    }
  ]
  vault = !local.parts_active.vault ? {} : merge(
    !var.vault_start ? {} : {
      write_files = concat(
        !(var.vault_install_method == "binary") ? [] : [
          {
            template = "${path.module}/templates/vault/${local.yml_write_files}_vault_service.tpl",
            vars = {
              vault_config_path = var.vault_config_path,
              vault_binary_path = local.vault_binary_paths[var.vault_install_method],
            }
          },
        ],
        !var.vault_init ? [] : [
          {
            template = "${path.module}/templates/vault/${local.yml_write_files}_vault_init_public_key.tpl",
            vars = {
              vault_init_public_key_full_path = local.vault_init_public_key_full_path,
              vault_init_public_key           = base64encode(var.vault_init_public_key),
            }
          }
        ]
      ),
    },
    {
      runcmd = concat(
        [
          {
            template = "${path.module}/templates/vault/${local.yml_runcmd}_bootstrap_files_path.tpl",
            vars = {
              vault_bootstrap_files_path = var.vault_bootstrap_files_path,
            }
          },
          {
            template = "${path.module}/templates/vault/${local.yml_runcmd}_${var.vault_install_method}_install.tpl",
            vars = {
              vault_version = var.vault_version, // ignored for vault_install_method 'apt'
            }
          },
          {
            template = "${path.module}/templates/vault/${local.yml_runcmd}_raft.tpl",
            vars = {
              vault_storage_raft_path = var.vault_storage_raft_path,
            }
          },
        ],
        !var.vault_start ? [] : concat(
          [
            {
              template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
              vars = {
                write_file_directory = var.vault_bootstrap_files_path,
                write_file_name      = "vault.hcl",
                write_file_content = templatefile("${path.module}/templates/vault/vault.hcl.tpl", {
                  vault_hcl_template_path     = var.vault_bootstrap_files_path,
                  vault_ui                    = var.vault_ui,
                  vault_log_level             = var.vault_log_level,
                  vault_api_addr              = var.vault_api_addr,
                  vault_cluster_addr          = local.vault_cluster_addr,
                  jsonencoded_vault_listeners = jsonencode(local.vault_listeners),
                  vault_storage_raft_path     = var.vault_storage_raft_path,
                  vault_storage_raft_node_id  = var.vault_storage_raft_node_id,
                  jsonencoded_vault_storage_raft_cluster_members = jsonencode(setsubtract(var.vault_storage_raft_cluster_members, [
                    var.vault_storage_raft_cluster_member_this
                  ])),
                  vault_storage_raft_retry_join_api_port     = var.vault_storage_raft_retry_join_api_port,
                  vault_storage_raft_leader_ca_cert_file     = local.vault_tls_storage_raft_leader_ca_cert_file,
                  vault_storage_raft_leader_client_cert_file = local.vault_tls_storage_raft_leader_client_cert_file,
                  vault_storage_raft_leader_client_key_file  = local.vault_tls_storage_raft_leader_client_key_file,
                  vault_raft_leader_tls_servername           = local.vault_raft_leader_tls_servername,
                  vault_disable_mlock                        = var.vault_disable_mlock,
                }),
                write_file_owner = "vault"
                write_file_group = "vault"
                write_file_mode  = "0644",
              }
            },
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_vault_hcl.tpl",
              vars = {
                vault_hcl_template_path = var.vault_bootstrap_files_path,
                vault_config_path       = var.vault_config_path,
              }
            },
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_lets_encrypt.tpl",
              vars     = {}
            },
          ],
          length(local.vault_tls_files) == 0 ? [] : [
            {
              template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
              vars = {
                runcmd_script = "  # tls files"
              }
            }
          ],
          [
            for vault_tls_file in local.vault_tls_files :
            {
              template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
              vars = {
                write_file_directory = dirname(vault_tls_file.file_name),
                write_file_name      = basename(vault_tls_file.file_name),
                write_file_content   = vault_tls_file.encoding == "base64" ? base64decode(vault_tls_file.content) : vault_tls_file.content,
                write_file_owner     = vault_tls_file.owner,
                write_file_group     = vault_tls_file.group,
                write_file_mode      = vault_tls_file.mode,
              }
            }
          ],
          length(local.vault_tls_contents) == 0 ? [] : [
            {
              template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
              vars = {
                runcmd_script = "  # tls files"
              }
            }
          ],
          [
            for vault_tls_content in local.vault_tls_contents :
            {
              template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
              vars = {
                write_file_directory = dirname(vault_tls_content.file_name),
                write_file_name      = basename(vault_tls_content.file_name),
                write_file_content   = vault_tls_content.encoding == "base64" ? base64decode(vault_tls_content.content) : vault_tls_content.content,
                write_file_owner     = vault_tls_content.owner,
                write_file_group     = vault_tls_content.group,
                write_file_mode      = vault_tls_content.mode,
              }
            }
          ],
          [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_service.tpl",
              vars     = {}
            },
          ],
          !var.vault_init ? [] : [
            {
              template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
              vars = {
                packages = join(" ", local.vault_init_needed_packages),
              }
            },
          ],
          !(var.vault_init && local.vault_init_with_pgp_keys) ? [] : [
            for i in range(var.vault_init_pgp_public_keys.num_internal_unseal_keys) :
            {
              template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
              vars = {
                write_file_directory = var.vault_bootstrap_files_path,
                write_file_name      = "vault_gpg_key${i}.conf",
                write_file_content = templatefile("${path.module}/templates/vault/gpg_key.conf.tpl", {
                  vault_gpg_key_name = "vault${i}",
                }),
                write_file_owner = "root"
                write_file_group = "root"
                write_file_mode  = "0644",
              }
            }
          ],
          !(var.vault_init && local.vault_init_with_pgp_keys) ? [] : [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_generate_pgp_keys.tpl",
              vars = {
                vault_bootstrap_files_path     = var.vault_bootstrap_files_path,
                vault_num_internal_unseal_keys = local.vault_num_internal_unseal_keys
              }
            }
          ],
          !var.vault_init ? [] : [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_init.tpl",
              vars = {
                vault_local_addr                = var.vault_local_addr,
                vault_key_shares                = var.vault_key_shares,
                vault_key_threshold             = var.vault_key_threshold,
                vault_init_json_full_path       = local.vault_init_json_full_path,
                vault_init_json_pub_full_path   = local.vault_init_json_pub_full_path,
                vault_init_json_file_mode       = var.vault_init_json_file_mode,
                vault_init_with_pgp_keys        = local.vault_init_with_pgp_keys,
                vault_num_internal_unseal_keys  = local.vault_num_internal_unseal_keys
                vault_pgp_pub_keys              = join(",", slice(local.vault_pgp_pub_keys, 0, var.vault_key_threshold)),
                jsonencoded_vault_pgp_priv_keys = jsonencode(local.vault_pgp_priv_keys)
              }
            },
          ],
          !var.vault_receive_vault_init_json ? [] : [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_receive_init.tpl",
              vars = {
                vault_init_json_full_path       = local.vault_init_json_full_path,
                vault_init_with_pgp_keys        = local.vault_init_with_pgp_keys,
                jsonencoded_vault_pgp_priv_keys = jsonencode(local.vault_pgp_priv_keys)
              }
            },
          ],
          !var.vault_unseal ? [] : [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_unseal.tpl",
              vars = {
                vault_local_addr          = var.vault_local_addr,
                vault_key_threshold       = var.vault_key_threshold,
                vault_init_json_full_path = local.vault_init_json_full_path,
                vault_init_with_pgp_keys  = local.vault_init_with_pgp_keys,
              }
            },
          ],
          !var.vault_spread_vault_init_json ? [] : [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_spread_init.tpl",
              vars = {
                jsonencoded_vault_storage_raft_cluster_members = jsonencode(setsubtract(var.vault_storage_raft_cluster_members, [
                  var.vault_storage_raft_cluster_member_this
                ])),
                vault_spread_vault_init_json_id_file        = var.vault_spread_vault_init_json_id_file,
                vault_init_json_full_path                   = local.vault_init_json_full_path,
                vault_remove_spread_vault_init_json_id_file = var.vault_remove_spread_vault_init_json_id_file,
                vault_init_with_pgp_keys                    = local.vault_init_with_pgp_keys,
                vault_bootstrap_files_path                  = var.vault_bootstrap_files_path,
                vault_pgp_priv_keys                         = join(" ", local.vault_pgp_priv_keys),
              }
            },
          ],
          !(var.vault_init && var.vault_revoke_root_token) ? [] : [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_revoke_root.tpl",
              vars = {
                vault_local_addr          = var.vault_local_addr,
                vault_init_json_full_path = local.vault_init_json_full_path,
              }
            },
          ],
          !(var.vault_init || var.vault_receive_vault_init_json) ? [] : [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_secure_init_json.tpl",
              vars = {
                vault_init_public_key_full_path      = local.vault_init_public_key_full_path,
                vault_init_json_full_path            = local.vault_init_json_full_path,
                vault_init_json_enc_full_path        = local.vault_init_json_enc_full_path,
                vault_init_json_enc_base64_full_path = local.vault_init_json_enc_base64_full_path,
                vault_init_json_file_mode            = var.vault_init_json_file_mode,
                vault_remove_vault_init_json         = var.vault_remove_vault_init_json ? "true" : null,
              }
            },
          ]
        )
      )
    }
  )
}
