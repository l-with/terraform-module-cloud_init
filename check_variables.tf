module "either_rke2_master_1st_or_rke2_master_other" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !(var.rke2_master_1st && var.rke2_master_other)
  error_message = "error: rke2_master_1st and rke2_master_other can not be used together"
}

module "rke2_master_1st_needs_rke2_secred_id" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !(var.rke2_master_1st && var.rke2_master_1st_rke2_secret_id == "")
  error_message = "error: rke2_master_1st needs rke2_secret_id"
}

locals {
  _rke2_master_vars = [
    for rke2_master_var in var.rke2_master_vars :
    rke2_master_var
  ]
  _rke2_master_vars_non_epmty = [
    for rke2_master_var in var.rke2_master_vars :
    rke2_master_var if rke2_master_var != ""
  ]
  num_rke2_master_vars_non_empty = length(local._rke2_master_vars_non_epmty)
  num_rke2_master_vars           = length(local._rke2_master_vars)
}

module "rke2_master_needs_rke2_master_vars" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !((var.rke2_master_1st || var.rke2_master_other) && length(local._rke2_master_vars_non_epmty) < local.num_rke2_master_vars)
  error_message = "error: rke2_master needs ${local.num_rke2_master_vars} rke2_master_vars (is ${local.num_rke2_master_vars_non_empty})"
}
