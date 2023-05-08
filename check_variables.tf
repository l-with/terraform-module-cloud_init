module "either_rke2_node_1st_or_rke2_node_other" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !(var.rke2_node_1st && var.rke2_node_other)
  error_message = "error: rke2_node_1st and rke2_node_other can not be used together"
}

module "rke2_node_needs_rke2_node_cert_package_url" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_cert_package_url == null)
  error_message = "error: rke2_node needs rke2_node_cert_package_url"
}

module "rke2_node_needs_encrypted_package_api_header" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_cert_package_api_header == null)
  error_message = "error: rke2_node needs rke2_node_cert_package_api_header"
}

module "rke2_node_needs_rke2_node_rke2_node_cert_package_secret" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_cert_package_secret == null)
  error_message = "error: rke2_node needs rke2_node_cert_package_secret"
}

module "rke2_node_needs_rke2_node_pre_shared_secret" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !((var.rke2_node_1st || var.rke2_node_other) && var.rke2_node_pre_shared_secret == null)
  error_message = "error: rke2_node needs rke2_node_pre_shared_secret"
}

module "rke2_node_1st_needs_rke2_node_1st_rke2_role_id" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !(var.rke2_node_1st && var.rke2_node_1st_rke2_role_id == null)
  error_message = "error: rke2_node_1st needs rke2_node_1st_rke2_role_id"
}

module "rke2_node_1st_needs_rke2_node_1st_rke2_secret_id" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !(var.rke2_node_1st && var.rke2_node_1st_rke2_secret_id == null)
  error_message = "error: rke2_node_1st needs rke2_node_1st_rke2_secret_id"
}

module "rke2_node_1st_needs_vault_addr" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !(var.rke2_node_1st && local.rke2_node_1st_vault_addr == null)
  error_message = "error: rke2_node_1st needs *_vault_addr"
}

module "rke2_node_other_needs_rke2_node_other_node_1st_ip" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  use_jq        = true
  assert        = !(var.rke2_node_other && var.rke2_node_other_node_1st_ip == null)
  error_message = "error: rke2_node_other needs rke2_node_other_node_1st_ip"
}
