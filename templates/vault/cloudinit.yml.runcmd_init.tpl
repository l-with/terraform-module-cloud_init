  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep "Active: active (running)" | wc -l | grep 1' 'systemctl status vault --no-pager'
  - >
    wait_until --verbose --delay 10 --retries 42 \
        --check 'grep --invert-match 0' 'vault status >/dev/null; echo $?'
  - export VAULT_ADDR=${vault_init_addr}
  - vault status -format=json | tee /root/vault_status.json
  - export VAULT_INITIALIZED=$(cat /root/vault_status.json | jq .initialized)
  - |
    if [ "$VAULT_INITIALIZED" = "false" ]; then
      vault operator init -key-shares ${vault_key_shares} -key-threshold ${vault_key_threshold} -format=json >/root/vault_init.json
      wait until --verbose --delay 10 --retries 42 \
        --check 'grep true' 'vault status -format=json | jq .initialized'
      i=0
      while [ $i -lt ${vault_key_threshold} ]
      do
        export VAULT_UNSEAL_KEY=$(cat /root/vault_init.json | jq .unseal_keys_b64[$i] --raw-output)
        vault operator unseal $VAULT_UNSEAL_KEY
        i=$((i+1))
      done
      wait until --verbose --delay 10 --retries 42 \
        --check 'grep false' 'vault status -format=json | jq .sealed'
      export VAULT_TOKEN=$(cat /root/vault_init.json | jq .root_token)
      vault token revoke $VAULT_TOKEN
      export VAULT_ENCRYPT_SECRET=${vault_encrypt_secret}
      tar -zc /root/vault_init.json | openssl enc -aes-256-cbc -pbkdf2 -out /root/${vault_init_artifact} -pass env:VAULT_ENCRYPT_SECRET
      s3cmd --access_key=${vault_s3_access_key} --secret_key=${vault_s3_secret_key} \
        --host=https://${vault_s3_host_base} '--host-bucket=%(bucket)s.${vault_s3_host_base}' \
        del /root/${vault_init_artifact} s3://${vault_s3_bucket}%{ if vault_s3_prefix != null }/${vault_s3_prefix}%{ endif }
      s3cmd --access_key=${vault_s3_access_key} --secret_key=${vault_s3_secret_key} \
        --host=https://${vault_s3_host_base} '--host-bucket=%(bucket)s.${vault_s3_host_base}' \
        put /root/${vault_init_artifact} s3://${vault_s3_bucket}%{ if vault_s3_prefix != null }/${vault_s3_prefix}%{ endif }
    fi
