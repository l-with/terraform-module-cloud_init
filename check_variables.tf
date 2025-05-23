module "either_rke2_node_1st_or_rke2_node_other" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.rke2_node_1st || var.rke2_node_other) ? 1 : 0

  use_jq        = true
  assert        = !(var.rke2_node_1st && var.rke2_node_other)
  error_message = "error: rke2_node_1st and rke2_node_other can not be used together"
}

module "rke2_node_needs_rke2_node_cert_package_url" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.rke2_node_1st || var.rke2_node_other) ? 1 : 0

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_cert_package_url == null)
  error_message = "error: rke2_node needs rke2_node_cert_package_url"
}

module "rke2_node_needs_encrypted_package_api_header" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.rke2_node_1st || var.rke2_node_other) ? 1 : 0

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_cert_package_api_header == null)
  error_message = "error: rke2_node needs rke2_node_cert_package_api_header"
}

module "rke2_node_needs_rke2_node_rke2_node_cert_package_secret" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.rke2_node_1st || var.rke2_node_other) ? 1 : 0

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_cert_package_secret == null)
  error_message = "error: rke2_node needs rke2_node_cert_package_secret"
}

module "rke2_node_needs_rke2_node_pre_shared_secret" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.rke2_node_1st || var.rke2_node_other) ? 1 : 0

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_pre_shared_secret == null)
  error_message = "error: rke2_node needs rke2_node_pre_shared_secret"
}

module "rke2_node_1st_needs_rke2_node_1st_rke2_role_id" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.rke2_node_1st ? 1 : 0

  use_jq        = true
  assert        = !(var.rke2_node_1st && var.rke2_node_1st_rke2_role_id == null)
  error_message = "error: rke2_node_1st needs rke2_node_1st_rke2_role_id"
}

module "rke2_node_1st_needs_rke2_node_1st_rke2_secret_id" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.rke2_node_1st ? 1 : 0

  use_jq        = true
  assert        = !(var.rke2_node_1st && var.rke2_node_1st_rke2_secret_id == null)
  error_message = "error: rke2_node_1st needs rke2_node_1st_rke2_secret_id"
}

module "rke2_node_1st_needs_vault_addr" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.rke2_node_1st ? 1 : 0

  use_jq        = true
  assert        = !(var.rke2_node_1st && local.rke2_node_1st_vault_addr == null)
  error_message = "error: rke2_node_1st needs *_vault_addr"
}

module "rke2_node_other_needs_rke2_node_other_node_1st_ip" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.rke2_node_other ? 1 : 0

  use_jq        = true
  assert        = !(var.rke2_node_other && var.rke2_node_other_node_1st_ip == null)
  error_message = "error: rke2_node_other needs rke2_node_other_node_1st_ip"
}

module "terraform_install_method_binary_needs_terraform_version" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.terraform && var.terraform_install_method == "binary") ? 1 : 0

  use_jq        = true
  assert        = !(var.terraform_install_method == "binary" && var.terraform_version == null)
  error_message = "error: terraform_install_method 'binary' needs terraform_version"
}

module "vault_start_needs_vault_api_addr" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.vault && var.vault_start) ? 1 : 0

  use_jq        = true
  assert        = !(var.vault && var.vault_start && var.vault_api_addr == null)
  error_message = "error: vault_start needs vault_api_addr"
}

module "vault_init_needs_vault_init_addr" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.vault && var.vault_start && var.vault_init) ? 1 : 0

  use_jq        = true
  assert        = !(var.vault && var.vault_start && var.vault_init && var.vault_local_addr == null)
  error_message = "error: vault_init needs vault_init_addr"
}

module "vault_secure_init_json_needs_vault_init_public_key" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.vault && var.vault_secure_init_json) ? 1 : 0

  use_jq        = true
  assert        = !(var.vault && var.vault_start && var.vault_init && var.vault_secure_init_json && var.vault_init_public_key == null)
  error_message = "error: vault_secure_init_json needs vault_init_public_key"
}

module "vault_spread_vault_init_json_needs_vault_spread_vault_init_json_id_file" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.vault && var.vault_start && var.vault_init && var.vault_spread_vault_init_json) ? 1 : 0

  use_jq        = true
  assert        = !(var.vault_spread_vault_init_json && var.vault_spread_vault_init_json_id_file == null)
  error_message = "error: vault_spread_vault_init_json needs vault_spread_vault_init_json_id_file"
}

module "vault_init_vault_key_threshold_less_than_or_equal_vault_key_shares" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.vault && var.vault_start && var.vault_init) ? 1 : 0

  use_jq        = true
  assert        = var.vault_key_threshold <= var.vault_key_shares
  error_message = "error: vault_key_threshold <= vault_key_shares"
}

module "vault_vault_init_pgp_public_keys_num_internal_unseal_keys_less_than_or_equal_vault_key_shares" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.vault_init_pgp_public_keys != null ? 1 : 0

  use_jq        = true
  assert        = !(var.vault_init_pgp_public_keys != null && local.vault_num_internal_unseal_keys > var.vault_key_shares)
  error_message = "error: vault_vault_init_pgp_public_keys.num_internal_unseal_keys > vault_key_shares"
}

module "vault_init_pgp_public_keys_needs_vault_vault_init_pgp_public_keys_num_internal_unseal_keys_plus_length_of_pgp_external_public_keys_equals_vault_key_shares" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.vault_init_pgp_public_keys != null ? 1 : 0

  use_jq        = true
  assert        = !(var.vault_init_pgp_public_keys != null && (local.vault_num_internal_unseal_keys + length(local.vault_pgp_external_public_keys)) != var.vault_key_shares)
  error_message = "error: vault_init_pgp_public_keys needs vault_vault_init_pgp_public_keys.num_internal_unseal_keys + length(vault_vault_init_pgp_public_keys.pgp_external_public_keys) != vault_key_shares"
}

module "vault_init_needs_jq_install_method_binary" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.vault && var.vault_start && var.vault_init) ? 1 : 0

  use_jq        = true
  assert        = !(var.vault_init && var.jq_install_method != "binary")
  error_message = "error: vault_init needs jq_install_method 'binary'"
}

module "vault_install_method_binary_needs_vault_version" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.vault && var.vault_install_method == "binary") ? 1 : 0

  use_jq        = true
  assert        = !(var.vault_install_method == "binary" && var.vault_version == null)
  error_message = "error: vault_install_method 'binary' needs vault_version"
}

module "vault_tls_file_encoding_either_text_plain_or_base64" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = length(var.vault_tls_files)

  use_jq        = true
  assert        = var.vault_tls_files[count.index].encoding == "text/plain" || var.vault_tls_files[count.index].encoding == "base64"
  error_message = "error: vault_tls_files encoding is not 'text/plain' or 'base64'"
}

module "write_files_encoding_either_text_plain_or_base64" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = length(var.write_files)

  use_jq        = true
  assert        = var.write_files[count.index].encoding == "text/plain" || var.write_files[count.index].encoding == "base64"
  error_message = "error: write_files encoding is not 'text/plain' or 'base64'"
}

module "mailcow_needs_mailcow_hostname" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.mailcow ? 1 : 0

  use_jq        = true
  assert        = !(var.mailcow && var.mailcow_hostname == null)
  error_message = "error: mailcow needs mailcow_hostname"
}

module "not_mailcow_dovecot_master_auto_generated_needs_mailcow_dovecot_master_user_and_mailcow_dovecot_master_password" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = !var.mailcow_dovecot_master_auto_generated ? 1 : 0

  use_jq        = true
  assert        = !(!var.mailcow_dovecot_master_auto_generated && (var.mailcow_dovecot_master_user == null || var.mailcow_dovecot_master_password == null))
  error_message = "error: not mailcow_dovecot_master_auto_generated needs mailcow_dovecot_master_user and mailcow_dovecot_master_password"
}

module "duplicacy_storage_backend_one_of" {
  count = var.duplicacy ? length(var.duplicacy_configurations) : 0

  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"


  use_jq        = true
  assert        = (contains(local.duplicacy_storage_backends, var.duplicacy_configurations[count.index].storage_backend))
  error_message = "error: '${var.duplicacy_configurations[count.index].storage_backend}' not in ${join(", ", local.duplicacy_storage_backends)}"
}

module "gzip_needs_base64_encode" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = var.gzip ? 1 : 0

  use_jq        = true
  assert        = !(var.gzip && !var.base64_encode)
  error_message = "error: gzip needs base64_encode"
}

module "docker_install_method_binary_needs_docker_version" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (var.docker && var.docker_install_method == "binary") ? 1 : 0

  use_jq        = true
  assert        = !(var.docker_install_method == "binary" && var.docker_version == null)
  error_message = "error: docker_install_method 'binary' needs docker_version"
}

module "containerd_install_method_binary_needs_containerd_version" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  count = (((var.docker && var.docker_install_method == "binary") || var.containerd) && var.containerd_install_method == "binary") ? 1 : 0

  use_jq        = true
  assert        = !(var.containerd_install_method == "binary" && var.containerd_version == null)
  error_message = "error: containerd_install_method 'binary' needs containerd_version"
}