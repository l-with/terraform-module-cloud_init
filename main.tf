locals {
  cloud_init_parts_keys_sorted = [
    "cloud_init_start",
    "cloud_init_runcmd",
    "rke2_master1",
    "rke2_master"
  ]
  cloud_init_parts = {
    cloud_init_start  = "#cloud-config"
    cloud_init_runcmd = "runcmd:"
    rke2_master1      = var.rke2_master_1st ? local.cloud_init_runcmd_rke2_master_1st : ""
    rke2_master       = var.rke2_master_other ? local.cloud_init_runcmd_rke2_master_other : ""
  }
  cloud_init_parts_sorted = [
    for key in local.cloud_init_parts_keys_sorted : local.cloud_init_parts[key]
  ]
}

locals {
  cloud_init = [
    for key in local.cloud_init_parts_keys_sorted :
    local.cloud_init_parts[key] if local.cloud_init_parts[key] != ""
  ]
}
