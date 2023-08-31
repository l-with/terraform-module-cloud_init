  # spread init
%{ for vault_instance in jsondecode(jsonencoded_vault_storage_raft_cluster_members) ~}
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep 0' 'scp -i ${vault_spread_vault_init_json_id_file} -o StrictHostKeyChecking=no ${vault_init_json_full_path} %{ if vault_init_with_pgp_keys ~}${vault_pgp_priv_keys}%{ endif } root@${vault_instance}:${vault_bootstrap_files_path}; echo $?'
%{ endfor ~}
%{ if vault_remove_spread_vault_init_json_id_file ~}
  - rm --force ${vault_spread_vault_init_json_id_file}
%{ endif ~}
