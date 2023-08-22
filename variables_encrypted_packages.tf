variable "encrypted_packages" {
  description = "if cloud-init user data for the encrypted packages should be generated"
  type        = bool
  default     = false
}

variable "encrypted_packages_list" {
  description = "the encrypted packages the cloud-init user data should be generated for"
  type = list(object({
    url        = string                                // the url to get the package from
    api_header = string                                // the header to authorize getting the package
    secret     = string                                // the secret to decrypt the package (`openssl enc -aes-256-cbc -pbkdf2`)"
    post_cmd   = optional(string, null)                // the command to be executed after the installing the package
    name       = optional(string, "encrypted_package") // the name of the encrypted package
  }))
  default   = []
  sensitive = true
}
