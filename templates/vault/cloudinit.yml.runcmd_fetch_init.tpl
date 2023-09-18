  # fetch init
  - export VAULT_CACERT=${vault_cacert}
%{ if vault_fetch_vault_init_json_from == null ~}
  - >
    while read -r vault_cluster_ip; do
      VAULT_ADDR=https://$vault_cluster_ip:${vault_auto_join_port} vault status --format=json >$${vault_cluster_ip}_status.json
      if $(cat $${vault_cluster_ip}_status.json | jq '.sealed | not'); then
        export VAULT_CLUSTER_IP=$vault_cluster_ip
        break
      fi
    done <${vault_cluster_ips_full_path}
%{ else ~}
  - export VAULT_CLUSTER_IP=${vault_fetch_vault_init_json_from}
%{ endif ~}
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep 0' 'scp -i ${vault_fetch_vault_init_json_id_file} -o StrictHostKeyChecking=no root@'$VAULT_CLUSTER_IP':{${vault_init_json_full_path},${vault_pgp_priv_keys},${vault_pgp_pub_keys}} ${vault_bootstrap_files_path}; echo $?'
  - export ip=$(head -n 1 ${vault_cluster_ips_full_path})
  - envsubst <${vault_ip_computation_command_full_path}.tlp >${vault_ip_computation_command_full_path}
  - chmod +x ${vault_ip_computation_command_full_path}
  - rm --force ${vault_ip_computation_command_full_path}
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep 0' 'scp -i ${vault_fetch_vault_init_json_id_file} -o StrictHostKeyChecking=no ${vault_ip_computation_command_full_path} root@'$VAULT_CLUSTER_IP':${vault_bootstrap_files_path}; echo $?'
%{ if vault_remove_fetch_vault_init_json_id_file ~}
  - rm --force ${vault_fetch_vault_init_json_id_file}
%{ endif ~}
