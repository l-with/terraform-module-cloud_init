variable "rke2_master_1st" {
  description = "if cloud-init user data for the rke2 1st masters should be generated"
  type        = bool
  default     = false
}

variable "rke2_master_other" {
  description = "if cloud-init user data for the rke2 other masters should be generated"
  type        = bool
  default     = false
}

variable "rke2_master_vars" {
  description = "the variables for cloud-init user data for rke2 1st and other masters"
  type = object({
    rke2_cert_package_url       = string
    rke2_cert_artifact          = string
    rke2_cert_package_api_token = string
    rke2_cert_package_secret    = string
    rke2_pre_shared_secret      = string
  })
  default = {
    rke2_cert_package_url       = ""
    rke2_cert_artifact          = ""
    rke2_cert_package_api_token = ""
    rke2_cert_package_secret    = ""
    rke2_pre_shared_secret      = ""
  }
}

variable "rke2_master_1st_vars" {
  description = "the variables for cloud-init user data for rke2 1st master"
  type = object({
    rke2_role_id   = string
    rke2_secret_id = string
  })
  default = {
    rke2_role_id   = ""
    rke2_secret_id = ""
  }
}

variable "rke2_master_other_vars" {
  description = "the variables for cloud-init user data for rke2 other masters"
  type = object({
    rke2_master1_ip = string
  })
  default = {
    rke2_master1_ip = ""
  }
}
