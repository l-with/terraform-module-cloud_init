variable "write_file" {
  description = "if files should be written"
  type        = bool
  default     = false
}

variable "write_files" {
  description = <<EOT
  the files to be written
  - encoding of the content can be 'text/plain' (default) or 'base64'
EOT
  type = list(object({
    file_name = string,
    content   = string,
    encoding  = optional(string, "text/plain"),
    owner     = optional(string, "root"),
    group     = optional(string, "root"),
    mode      = optional(string, "644"),
  }))
  default = []
}
