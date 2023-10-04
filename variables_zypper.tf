variable "zypper" {
  description = "if cloud-init user data for adding zypper repositories should be generated"
  type        = bool
  default     = false
}

variable "zypper_repositories" {
  description = "the zypper repositories that should be added"
  type = list(object({
    uri   = string,
    alias = string,
  }))
  default = [
    {
      uri   = "http://download.opensuse.org/distribution/leap/15.5/repo/oss/"
      alias = "opensuse-oss-leap-15.5"
    }
  ]
}
