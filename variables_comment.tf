variable "comment" {
  description = "if cloud-init user data with comments should be generated"
  type        = bool
  default     = false
}

variable "comments" {
  description = <<EOT
    the comments to be added to cloud-init user data
    this can be used to change cloud-init user-data to trigger rebuild without changing relevant data
  EOT
  type        = list(string)
  default     = []
  validation {
    condition = !contains(
      [
        for comment in var.comments :
        false if !startswith(comment, "#")
      ],
      false
    )
    error_message = "the comments must start with '#'"
  }
}
