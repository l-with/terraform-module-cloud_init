locals {
  vault_addr = coalesce(var.rke2_node_1st_vault_addr, var.vault_addr)
}

locals {
  cloud_init_runcmd_rke2_prefix = "${path.module}/templates/rke2/cloudinit.yml.runcmd"

  cloud_init_runcmd_rke2_node_begin_template             = "${local.cloud_init_runcmd_rke2_prefix}_begin.tpl"
  cloud_init_runcmd_rke2_node_1st_manifests_template     = "${local.cloud_init_runcmd_rke2_prefix}_manifests.tpl"
  cloud_init_runcmd_rke2_node_server_template            = "${local.cloud_init_runcmd_rke2_prefix}_rke2-server.tpl"
  cloud_init_runcmd_rke2_node_1st_kubectl2vault_template = "${local.cloud_init_runcmd_rke2_prefix}_kubeconfig2vault.tpl"

  cloud_init_runcmd_rke2_node_1st = join(
    "\n", [
      templatefile(local.cloud_init_runcmd_rke2_node_begin_template, {
        rke2_cert_package_url        = var.rke2_node_vars.rke2_cert_package_url
        rke2_cert_package_api_header = var.rke2_node_vars.rke2_cert_package_api_header
        rke2_cert_package_secret     = var.rke2_node_vars.rke2_cert_package_secret
        rke2_pre_shared_secret       = var.rke2_node_vars.rke2_pre_shared_secret
        rke2_config_template         = "/root/config.yaml.node_1st.envtpl"
        rke2_node_1st_ip             = ""
      }),
      templatefile(local.cloud_init_runcmd_rke2_node_1st_manifests_template, {
        cert_manager_crd_version = var.rke2_node_1st_cert_manager_crd_version
      }),
      templatefile(local.cloud_init_runcmd_rke2_node_server_template, {}),
      templatefile(local.cloud_init_runcmd_rke2_node_1st_kubectl2vault_template, {
        rke2_role_id             = var.rke2_node_1st_rke2_role_id
        rke2_secret_id           = var.rke2_node_1st_rke2_secret_id
        cert_manager_crd_version = var.rke2_node_1st_cert_manager_crd_version
        vault_addr               = var.rke2_node_1st_vault_addr
        vault_mount              = var.rke2_node_1st_vault_mount
        vault_path               = var.rke2_node_1st_vault_path
        vault_field              = var.rke2_node_1st_vault_field
      })
    ]
  )
  cloud_init_runcmd_rke2_node_other = join(
    "\n", [
      templatefile(local.cloud_init_runcmd_rke2_node_begin_template, {
        rke2_cert_package_url        = var.rke2_node_vars.rke2_cert_package_url
        rke2_cert_package_api_header = var.rke2_node_vars.rke2_cert_package_api_header
        rke2_cert_package_secret     = var.rke2_node_vars.rke2_cert_package_secret
        rke2_pre_shared_secret       = var.rke2_node_vars.rke2_pre_shared_secret
        rke2_config_template         = "/root/config.yaml.node_other.envtpl"
        rke2_node_1st_ip             = var.rke2_node_other_node_1st_ip
      }),
      templatefile(local.cloud_init_runcmd_rke2_node_server_template, {})
    ]
  )
}