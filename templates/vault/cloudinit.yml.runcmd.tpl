  - >
    curl --remote-name https://releases.hashicorp.com/vault/${vault_version}/vault_${vault_version}_linux_amd64.zip
  - unzip vault_${vault_version}_linux_amd64.zip
  - chmod + x vault
  - mv vault /usr/local/bin
  - rm vault_${vault_version}_linux_amd64.zip
