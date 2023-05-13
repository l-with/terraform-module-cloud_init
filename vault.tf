locals {
  vault_binary_paths = {
    apt    = "/usr/bin",
    binary = "/usr/local/bin"
  }
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
  vault_hcl_template_path = "/root"
  vault = merge(
    {
      packages = [
        {
          template = "${path.module}/templates/vault/${local.yml_packages}.tpl",
          vars     = {}
        },
      ]
      runcmd = concat(
        [
          {
            template = "${path.module}/templates/vault/${local.yml_runcmd}_${var.vault_install_method}_install.tpl",
            vars     = {}
          },
          {
            template = "${path.module}/templates/vault/${local.yml_runcmd}_raft.tpl",
            vars = {
              vault_storage_raft_path = var.vault_storage_raft_path
            }
          },
        ],
        !var.vault_start ? [] : concat(
          [
            {
              template = "${path.module}/templates/vault/${local.yml_runcmd}_vault_hcl.tpl",
              vars = {
                vault_hcl_template_path = local.vault_hcl_template_path
                vault_config_path       = var.vault_config_path
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
              template = "${path.module}/templates/vault/${local.yml_runcmd}_init.tpl",
              vars = {
                vault_init_addr      = var.vault_init_addr
                vault_key_shares     = var.vault_key_shares
                vault_key_threshold  = var.vault_key_threshold
                vault_encrypt_secret = var.vault_init_encrypt_secret
                vault_init_artifact  = var.vault_init_artifact
                vault_s3_access_key  = var.vault_init_s3cfg.access_key,
                vault_s3_secret_key  = var.vault_init_s3cfg.secret_key,
                vault_s3_host_base   = var.vault_init_s3cfg.host_base,
                vault_s3_bucket      = var.vault_init_s3cfg.bucket,
                vault_s3_prefix      = var.vault_init_s3cfg.prefix,
              }
            },
          ],
        )
      )
    },
    !var.vault_start ? {} : {
      write_files = concat(
        [
          {
            template = "${path.module}/templates/vault/${local.yml_write_files}_vault_service.tpl",
            vars = {
              vault_config_path = var.vault_config_path,
              vault_binary_path = local.vault_binary_paths[var.vault_install_method],
            }
          },
          {
            template = "${path.module}/templates/vault/${local.yml_write_files}_vault_hcl.tpl",
            vars = {
              vault_hcl_template_path                    = local.vault_hcl_template_path,
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
      ),
    }
  )
}
