  # init
  - export VAULT_ADDR=${vault_local_addr}
  - vault operator init -key-shares ${vault_key_shares} -key-threshold ${vault_key_threshold} %{ if vault_init_with_pgp_keys ~}-pgp-keys "${vault_pgp_pub_keys}"%{ endif } -format=json >${vault_init_json_full_path}
  - chmod ${vault_init_json_file_mode} ${vault_init_json_full_path}
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep true' 'vault status -format=json | jq .initialized'
%{ if vault_init_with_pgp_keys ~}
  - cat ${vault_init_json_full_path} | jq '.del(.root_token)' >${vault_init_json_pub_full_path}
  - >
    i=0; while [ $i -lt ${vault_key_shares} ]; do
      if [ $i -lt ${vault_num_internal_unseal_keys} ]; then
      export VAULT_UNSEAL_KEY=$(cat ${vault_init_json_full_path} | jq .unseal_keys_b64[$i] --raw-output | base64 -d |  gpg --decrypt | base64)
      cat ${vault_init_json_full_path} | jq '.unseal_keys_b64[$i] = env.VAULT_UNSEAL_KEY' >${vault_init_json_full_path}.$i
      mv ${vault_init_json_full_path}.$i ${vault_init_json_full_path}
      i=$((i+1))
    done
%{ endif ~}

