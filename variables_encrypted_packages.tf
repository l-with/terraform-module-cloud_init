variable "encrypted_packages" {
  description = "the encrypted packages the cloud-init user data should be generated for"
  type = list({
    url        = string // the url to get the package from
    api_header = string // the header to authorize getting the package
    secret     = string // the secret to decrypt the package (`openssl enc -aes-256-cbc -pbkdf2`)"
  })
  default = []
}
