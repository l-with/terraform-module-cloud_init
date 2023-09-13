variable "part" {
  description = "the name of the cloud-init part"
  type        = string
}

variable "users" {
  description = "the parameters for users"
  type = list(object({
    template = string,
    vars     = map(string)
  }))
  default = []
}

variable "packages" {
  description = "the parameters for packages"
  type = list(object({
    template = string,
    vars     = map(string)
  }))
  default = []
}

variable "write_files" {
  description = "the parameters for write_file"
  type = list(object({
    template = string,
    vars     = map(string)
  }))
  default = []
}

variable "runcmd" {
  description = "the parameters for runcmd"
  type = list(object({
    template = string,
    vars     = map(string)
  }))
  default = []
}
