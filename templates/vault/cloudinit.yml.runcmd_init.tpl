  # init
  - export VAULT_ADDR=${vault_local_addr}
  - vault operator init -key-shares ${vault_key_shares} -key-threshold ${vault_key_threshold} %{ if vault_init_with_pgp_keys ~}-pgp-keys "${vault_pgp_pub_keys}"%{ endif } -format=json >${vault_init_json_full_path}
  - chmod ${vault_init_json_file_mode} ${vault_init_json_full_path}
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep true' 'vault status -format=json | jq .initialized'
%{ if vault_init_with_pgp_keys ~}
  - cat ${vault_init_json_full_path} | jq 'del(.root_token)' >${vault_init_json_pub_full_path}
  - cat ${vault_init_json_full_path} | jq 'del(.unseal_keys_hex)' >${vault_init_json_full_path}._
  - mv ${vault_init_json_full_path}._ ${vault_init_json_full_path};
  - >
    export i=0; while [ $i -lt ${vault_key_shares} ]; do
      if [ $i -ge ${vault_num_internal_unseal_keys} ]; then
        cat ${vault_init_json_full_path} | jq '(env.i | tonumber) as $i | del(.unseal_keys_b64[$i])' >${vault_init_json_full_path}.$i;
        mv ${vault_init_json_full_path}.$i ${vault_init_json_full_path};
      fi;
      export VAULT_UNSEAL_KEY=$(cat ${vault_init_json_full_path} | jq '.unseal_keys_b64 | (env.i | tonumber) as $i | .[$i]' --raw-output | base64 -d |  gpg --decrypt);
      cat ${vault_init_json_full_path} | jq '(env.i | tonumber) as $i | .unseal_keys_b64[$i]=env.VAULT_UNSEAL_KEY' >${vault_init_json_full_path}.$i;
      mv ${vault_init_json_full_path}.$i ${vault_init_json_full_path};
      i=$((i+1));
    done
%{ endif ~}

