module "either_rke2_master_1st_or_rke2_master_other" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !(var.rke2_master_1st && var.rke2_master_other)
  error_message = "error: rke2_master_1st and rke2_master_other can not be used together"
}

module "rke2_master_1st_needs_rke2_secred_id" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !(var.rke2_master_1st && var.rke2_master_1st_vars.rke2_secret_id == "")
  error_message = "error: rke2_master_1st needs rke2_secret_id"
}

locals {
  rke2_master_vars = [
    for rke2_master_var in var.rke2_master_vars :
    rke2_master_var if rke2_master_var != ""
  ]
}

module "rke2_master_needs_rke2_master_vars" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !((var.rke2_master_1st || var.rke2_master_other) && length(local.rke2_master_vars) < 5)
  error_message = "error: rke2_master needs 5 rke2_master_vars"
}

module "rke2_master_1st_needs_vault_addr" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !(var.rke2_master_1st && local.vault_addr == "")
  error_message = "error: rke2_master_1st needs vault_addr"
}
