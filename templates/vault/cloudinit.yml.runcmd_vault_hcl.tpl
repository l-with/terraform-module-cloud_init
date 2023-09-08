  # vault hcl
  - |
    export ipv4_address=$(${ipv4_address_command})
  - envsubst < ${vault_hcl_template_path}/vault.hcl > ${vault_config_path}/vault.hcl
  - rm --force ${vault_hcl_template_path}/vault.hcl
