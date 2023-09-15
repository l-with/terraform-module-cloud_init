variable "golang" {
  description = "if cloud-init user data for installing golang should be generated"
  type        = bool
  default     = false
}

variable "golang_tools" {
  description = "the golang tools to be installed  used as parameter for `go install`"
  type        = list(string)
  default     = []
}
