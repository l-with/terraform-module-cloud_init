  # spread init
  - >
    while read -r vault_cluster_ip; do
        wait_until --verbose --delay 10 --retries 42 \
            --check 'grep 0' 'scp -i ${vault_spread_vault_init_json_id_file} -o StrictHostKeyChecking=no ${vault_init_json_full_path} ${vault_pgp_priv_keys} ${vault_pgp_pub_keys} root@'$vault_cluster_ip':${vault_bootstrap_files_path}; echo $?'
    done <${vault_cluster_ips_full_path}
%{ if vault_remove_spread_vault_init_json_id_file ~}
  - rm --force ${vault_spread_vault_init_json_id_file}
%{ endif ~}
