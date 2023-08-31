  # binary install
  - >
    curl --remote-name --location https://releases.hashicorp.com/terraform/${vault_version}/terraform_${vault_version}_linux_amd64.zip
  - unzip terraform_${vault_version}_linux_amd64.zip
  - mv vault /usr/local/bin
  - rm --force terraform_${vault_version}_linux_amd64.zip
