locals {
  cloud_init_runcmd_rke2_prefix = "${path.module}/templates/rke2/cloudinit.yml.runcmd"

  cloud_init_runcmd_rke2_master_begin_template             = "${local.cloud_init_runcmd_rke2_prefix}_begin.tpl"
  cloud_init_runcmd_rke2_master_1st_manifests_template     = "${local.cloud_init_runcmd_rke2_prefix}_manifests.tpl"
  cloud_init_runcmd_rke2_server_template                   = "${local.cloud_init_runcmd_rke2_prefix}_rke2-server.tpl"
  cloud_init_runcmd_rke2_master_1st_kubectl2vault_template = "${local.cloud_init_runcmd_rke2_prefix}_kubeconfig2vault.tpl"

  cloud_init_runcmd_rke2_master_1st = join(
    "\n", [
      templatefile(local.cloud_init_runcmd_rke2_master_begin_template, {
        rke2_cert_package_url       = var.rke2_master_vars.rke2_cert_package_url
        rke2_cert_artifact          = var.rke2_master_vars.rke2_cert_artifact
        rke2_cert_package_api_token = var.rke2_master_vars.rke2_cert_package_api_token
        rke2_cert_package_secret    = var.rke2_master_vars.rke2_cert_package_secret
        rke2_pre_shared_secret      = var.rke2_master_vars.rke2_pre_shared_secret
        rke2_config_template        = "/root/config.yaml.master1.envtpl"
        rke2_master1_ip             = ""
      }),
      templatefile(local.cloud_init_runcmd_rke2_master_1st_manifests_template, {}),
      templatefile(local.cloud_init_runcmd_rke2_server_template, {}),
      templatefile(local.cloud_init_runcmd_rke2_master_1st_kubectl2vault_template, {
        rke2_role_id   = var.rke2_master_1st_vars.rke2_role_id
        rke2_secret_id = var.rke2_master_1st_vars.rke2_secret_id
        vault_addr     = var.rke2_master_1st_vars.vault_addr
      })
    ]
  )
  cloud_init_runcmd_rke2_master_other = join(
    "\n", [
      templatefile(local.cloud_init_runcmd_rke2_master_begin_template, {
        rke2_cert_package_url       = var.rke2_master_vars.rke2_cert_package_url
        rke2_cert_artifact          = var.rke2_master_vars.rke2_cert_artifact
        rke2_cert_package_secret    = var.rke2_master_vars.rke2_cert_package_secret
        rke2_cert_package_api_token = var.rke2_master_vars.rke2_cert_package_api_token
        rke2_pre_shared_secret      = var.rke2_master_vars.rke2_pre_shared_secret
        rke2_config_template        = "/root/config.yaml.envtpl"
        rke2_master1_ip             = var.rke2_master_other_vars.rke2_master1_ip
      }),
      templatefile(local.cloud_init_runcmd_rke2_server_template, {})
    ]
  )
}