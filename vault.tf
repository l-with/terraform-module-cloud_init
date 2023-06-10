locals {
  vault_binary_paths = {
    apt    = "/usr/bin",
    binary = "/usr/local/bin"
  }
  vault_init_public_key_full_path      = "${var.vault_bootstrap_files_path}/vault_init_public.key"
  vault_init_json_enc_full_path        = "${var.vault_bootstrap_files_path}/vault_init_json.enc"
  vault_init_json_enc_base64_full_path = "${local.vault_init_json_enc_full_path}.base64"
  vault_init_needed_packages = [
    "openssl",
  ]
  vault_tls_cert_file      = var.vault_tls_cert_file != null ? var.vault_tls_cert_file : var.vault_storage_raft_leader_client_cert_file
  vault_tls_key_file       = var.vault_tls_key_file != null ? var.vault_tls_key_file : var.vault_storage_raft_leader_client_key_file
  vault_tls_client_ca_file = var.vault_tls_client_ca_file != null ? var.vault_tls_client_ca_file : var.vault_storage_raft_leader_ca_cert_file
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
        [
          {
            template = "${path.module}/templates/vault/${local.yml_write_files}_vault_hcl.tpl",
            vars = {
              vault_hcl_template_path                    = var.vault_bootstrap_files_path,
              vault_ui                                   = var.vault_ui,
              vault_log_level                            = var.vault_log_level,
              vault_api_addr                             = var.vault_api_addr,
              vault_cluster_addr                         = var.vault_cluster_addr,
              vault_listeners                            = jsonencode(local.vault_listeners),
              vault_storage_raft_path                    = var.vault_storage_raft_path,
              vault_storage_raft_node_id                 = var.vault_storage_raft_node_id,
              vault_storage_raft_cluster_members         = jsonencode(setsubtract(var.vault_storage_raft_cluster_members, [var.vault_storage_raft_cluster_member_this])),
              vault_storage_raft_retry_join_api_port     = var.vault_storage_raft_retry_join_api_port,
              vault_storage_raft_leader_ca_cert_file     = var.vault_storage_raft_leader_ca_cert_file,
              vault_storage_raft_leader_client_cert_file = var.vault_storage_raft_leader_client_cert_file,
              vault_storage_raft_leader_client_key_file  = var.vault_storage_raft_leader_client_key_file,
              vault_raft_leader_tls_servername           = var.vault_raft_leader_tls_servername,
              vault_disable_mlock                        = var.vault_disable_mlock,
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
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_init.tpl",
              vars = {
                vault_init_addr                      = var.vault_init_addr,
                vault_key_shares                     = var.vault_key_shares,
                vault_key_threshold                  = var.vault_key_threshold,
                vault_bootstrap_files_path           = var.vault_bootstrap_files_path,
                vault_init_public_key_full_path      = local.vault_init_public_key_full_path,
                vault_init_json_enc_full_path        = local.vault_init_json_enc_full_path,
                vault_init_json_enc_base64_full_path = local.vault_init_json_enc_base64_full_path
                vault_remove_vault_init_json         = var.vault_remove_vault_init_json ? "true" : null,
              }
            },
          ],
        )
      )
    },
  )
}
