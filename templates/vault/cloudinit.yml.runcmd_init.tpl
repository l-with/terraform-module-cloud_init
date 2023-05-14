  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep "Active: active (running)" | wc -l | grep 1' 'systemctl status vault --no-pager'
  - >
    wait_until --verbose --delay 10 --retries 42 \
        --check 'grep --invert-match 0' 'vault status >/dev/null; echo $?'
  - export VAULT_ADDR=${vault_init_addr}
  - export VAULT_STATUS_JSON=/root/vault_status.json
  - vault status -format=json | tee $VAULT_STATUS_JSON
  - export VAULT_INITIALIZED=$(cat $VAULT_STATUS_JSON | jq .initialized)
  - export VAULT_INIT_JSON=/root/vault_init.json
  - |
    if [ "$VAULT_INITIALIZED" = "false" ]; then
      vault operator init -key-shares ${vault_key_shares} -key-threshold ${vault_key_threshold} -format=json >$VAULT_INIT_JSON
      wait until --verbose --delay 10 --retries 42 \
        --check 'grep true' 'vault status -format=json | jq .initialized'
      i=0
      while [ $i -lt ${vault_key_threshold} ]
      do
        export VAULT_UNSEAL_KEY=$(cat $VAULT_INIT_JSON | jq .unseal_keys_b64[$i] --raw-output)
        vault operator unseal $VAULT_UNSEAL_KEY
        i=$((i+1))
      done
      wait until --verbose --delay 10 --retries 42 \
        --check 'grep false' 'vault status -format=json | jq .sealed'
      export VAULT_TOKEN=$(cat $VAULT_INIT_JSON | jq .root_token)
      vault token revoke $VAULT_TOKEN
      tar --gzip --create --file $VAULT_INIT_JSON.tgz $VAULT_INIT_JSON
      openssl pkeyutl -encrypt -pubin -inkey ${vault_init_public_key_full_path} -in $VAULT_INIT_JSON.tgz -out /root/${vault_init_artifact}
      rm -rf $VAULT_INIT_JSON.tgz
      s3cmd --access_key=${vault_s3_access_key} --secret_key=${vault_s3_secret_key} \
        --host=https://${vault_s3_host_base} '--host-bucket=%(bucket)s.${vault_s3_host_base}' \
        del /root/${vault_init_artifact} s3://${vault_s3_bucket}%{ if vault_s3_prefix != null }/${vault_s3_prefix}%{ endif }
      s3cmd --access_key=${vault_s3_access_key} --secret_key=${vault_s3_secret_key} \
        --host=https://${vault_s3_host_base} '--host-bucket=%(bucket)s.${vault_s3_host_base}' \
        put /root/${vault_init_artifact} s3://${vault_s3_bucket}%{ if vault_s3_prefix != null }/${vault_s3_prefix}%{ endif }
      rm --force $VAULT_INIT_JSON
    fi
