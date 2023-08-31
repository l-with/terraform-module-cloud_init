  # vault hcl
  - |
    export ipv4_address=$(ip addr show | grep 'inet ' | grep 'scope global' | cut -d ' ' -f6 | cut -d '/' -f 1)
  - envsubst < ${vault_hcl_template_path}/vault.hcl > ${vault_config_path}/vault.hcl
  - rm --force ${vault_hcl_template_path}/vault.hcl
