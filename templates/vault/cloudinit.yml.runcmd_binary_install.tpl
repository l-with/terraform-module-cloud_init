  # binary install
  - >
    curl --remote-name --location https://releases.hashicorp.com/vault/${vault_version}/vault_${vault_version}_linux_amd64.zip
  - unzip vault_${vault_version}_linux_amd64.zip
  - mv vault /usr/local/bin
  - rm --force vault_${vault_version}_linux_amd64.zip
