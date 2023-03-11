module "errorcheck_valid" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.3.0"

  assert        = !(var.rke2_master_other && var.rke2_master_1st)
  error_message = "error: rke_master1 and rke_master can not be used together"
}