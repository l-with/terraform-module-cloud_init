  # vault hcl
  - |
    export ipv4_address=$(${ipv4_address_command})
%{ for ip_address in jsondecode(jsonencoded_ip_addresses) ~}
  - |
    export ip_address_${ip_address.ip_address_suffix}=$(${ip_address.computation_command})
%{ endfor ~}
  - envsubst < ${vault_hcl_template_path}/vault.hcl > ${vault_config_path}/vault.hcl
  - rm --force ${vault_hcl_template_path}/vault.hcl
