  # spread init
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep 0' 'scp -i ${vault_spread_vault_init_json_id_file} -o StrictHostKeyChecking=no root@${vault_fetch_vault_init_json_from}:{${vault_init_json_full_path},${vault_pgp_priv_keys},${vault_pgp_pub_keys}} ; echo $?'
  - rm --force ${vault_spread_vault_init_json_id_file}
