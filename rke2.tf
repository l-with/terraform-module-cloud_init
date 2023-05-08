locals {
  rke2_node_1st_vault_addr = var.rke2_node_1st_vault_addr != null ? var.rke2_node_1st_vault_addr : var.vault_addr
}

locals {
  rke2_node_1st = !var.rke2_node_1st ? {} : {
    runcmd = [
      {
        template = "${path.module}/templates/encrypted_packages/${local.yml_runcmd}.tpl",
        vars = {
          url        = var.rke2_node_cert_package_url
          api_header = var.rke2_node_cert_package_api_header
          secret     = var.rke2_node_cert_package_secret
          post_cmd   = ""
        }
      },
      {
        template = "${path.module}/templates/rke2/${local.yml_runcmd}_begin.tpl",
        vars = {
          rke2_pre_shared_secret    = var.rke2_node_pre_shared_secret
          rke2_config_template      = "/root/config.yaml.node_1st.envtpl"
          rke2_node_1st_ip          = ""
          rke2_node_config_addendum = var.rke2_node_config_addendum
        }
      },
      {
        template = "${path.module}/templates/rke2/${local.yml_runcmd}_manifests.tpl",
        vars = {
          cert_manager_crd_version = var.rke2_node_1st_cert_manager_crd_version
        }
      },
      {
        template = "${path.module}/templates/rke2/${local.yml_runcmd}_rke2-server.tpl",
        vars     = {}
      },
      {
        template = "${path.module}/templates/rke2/${local.yml_runcmd}_kubeconfig2vault.tpl",
        vars = {
          rke2_role_id             = var.rke2_node_1st_rke2_role_id
          rke2_secret_id           = var.rke2_node_1st_rke2_secret_id
          cert_manager_crd_version = var.rke2_node_1st_cert_manager_crd_version
          vault_addr               = local.rke2_node_1st_vault_addr
          vault_mount              = var.rke2_node_1st_vault_mount
          vault_path               = var.rke2_node_1st_vault_path
          vault_field              = var.rke2_node_1st_vault_field
        }
      },
    ]
  }
}

locals {
  rke2_node_other = !var.rke2_node_other ? {} : {
    runcmd = [
      {
        template = "${path.module}/templates/encrypted_packages/${local.yml_runcmd}.tpl",
        vars = {
          url        = var.rke2_node_cert_package_url
          api_header = var.rke2_node_cert_package_api_header
          secret     = var.rke2_node_cert_package_secret
          post_cmd   = ""
        }
      },
      {
        template = "${path.module}/templates/rke2/${local.yml_runcmd}_begin.tpl",
        vars = {
          rke2_pre_shared_secret    = var.rke2_node_pre_shared_secret
          rke2_config_template      = "/root/config.yaml.node_other.envtpl"
          rke2_node_1st_ip          = var.rke2_node_other_node_1st_ip
          rke2_node_config_addendum = var.rke2_node_config_addendum
        }
      },
      {
        template = "${path.module}/templates/rke2/${local.yml_runcmd}_rke2-server.tpl",
        vars     = {}
      },
    ]
  }
}
