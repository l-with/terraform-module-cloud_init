  - export VAULT_ADDR=${vault_local_addr}
  - vault operator init -key-shares ${vault_key_shares} -key-threshold ${vault_key_threshold} %{ if vault_init_with_pgp_keys ~}-pgp-keys "${vault_pgp_pub_keys}"%{ endif } -format=json >${vault_init_json_full_path}
  - chmod ${vault_init_json_file_mode} ${vault_init_json_full_path}
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep true' 'vault status -format=json | jq .initialized'
