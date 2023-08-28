  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep "Active: active (running)" | wc -l | grep 1' 'systemctl status vault --no-pager'
  - export VAULT_ADDR=${vault_local_addr}
  - >
    i=0
    while [ $i -lt ${vault_key_threshold} ]
    do
      export VAULT_UNSEAL_KEY=$(cat ${vault_init_json_full_path} | jq .unseal_keys_b64[$i] --raw-output)
      vault operator unseal $VAULT_UNSEAL_KEY
      i=$((i+1))
    done
  - >
    wait_until --verbose --delay 10 --retries 42 \
       --check 'grep false' 'vault status -format=json | jq .sealed'
