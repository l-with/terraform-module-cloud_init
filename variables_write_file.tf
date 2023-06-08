variable "write_file" {
  description = "if files should be written"
  type        = bool
  default     = false
}

variable "write_files" {
  description = "the files to be written"
  type = list(object({
    file_name = string,
    content   = string,
    mode      = string,
  }))
  default = []
}
