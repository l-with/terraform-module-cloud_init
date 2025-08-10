  # binary install
  - >
    curl --fail-with-body --remove-on-error --location ${vault_zipped_binary_url} --output vault_${vault_version}.zip
  - >
    unzip vault_${vault_version}.zip vault && mv vault /usr/local/bin && rm --force vault_${vault_version}.zip
  - useradd --system --user-group --shell /bin/false vault
  - mkdir --parent ${vault_config_path}
  - chown vault:vault ${vault_config_path}
  - touch ${vault_config_path}/vault.env
  - chown vault:vault ${vault_config_path}/vault.env
