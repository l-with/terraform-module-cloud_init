  # binary install
  - >
    curl --remote-name --location https://releases.hashicorp.com/vault/${vault_version}/vault_${vault_version}_linux_amd64.zip
  - >
    unzip vault_${vault_version}_linux_amd64.zip && mv vault /usr/local/bin && rm --force vault_${vault_version}_linux_amd64.zip
  - useradd --system --user-group --shell /bin/false vault
  - mkdir --parent ${vault_config_path}
  - chown vault:vault ${vault_config_path}
  - touch ${vault_config_path}/vault.env
  - chown vault:vault ${vault_config_path}/vault.env
