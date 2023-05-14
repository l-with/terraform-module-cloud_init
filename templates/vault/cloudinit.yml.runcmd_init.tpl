  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep "Active: active (running)" | wc -l | grep 1' 'systemctl status vault --no-pager'
  - >
    wait_until --verbose --delay 10 --retries 42 \
        --check 'grep --invert-match 0' 'vault status >/dev/null; echo $?'
  - export VAULT_ADDR=${vault_init_addr}
  - export VAULT_STATUS_JSON=${vault_bootstrap_files_path}/vault_status.json
  - vault status -format=json | tee $VAULT_STATUS_JSON
  - export VAULT_INITIALIZED=$(cat $VAULT_STATUS_JSON | jq .initialized)
  - export VAULT_INIT_JSON=${vault_bootstrap_files_path}/vault_init.json
  - |
    if [ "$VAULT_INITIALIZED" = "false" ]; then
      vault operator init -key-shares ${vault_key_shares} -key-threshold ${vault_key_threshold} -format=json >$VAULT_INIT_JSON
      wait_until --verbose --delay 10 --retries 42 \
        --check 'grep true' 'vault status -format=json | jq .initialized'
      i=0
      while [ $i -lt ${vault_key_threshold} ]
      do
        export VAULT_UNSEAL_KEY=$(cat $VAULT_INIT_JSON | jq .unseal_keys_b64[$i] --raw-output)
        vault operator unseal $VAULT_UNSEAL_KEY
        i=$((i+1))
      done
      wait_until --verbose --delay 10 --retries 42 \
        --check 'grep false' 'vault status -format=json | jq .sealed'
      export VAULT_TOKEN=$(cat $VAULT_INIT_JSON | jq .root_token --raw-output)
      vault token revoke $VAULT_TOKEN
      openssl pkeyutl -encrypt -pubin -inkey ${vault_init_public_key_full_path} -in $VAULT_INIT_JSON -out ${vault_init_json_enc_full_path}
      base64 ${vault_init_json_enc_full_path} >${vault_init_json_enc_base64_full_path}
      rm --force $VAULT_INIT_JSON.tgz%{if vault_remove_vault_init_json != null}
      rm --force $VAULT_INIT_JSON%{ endif }
    fi
