  - >
    wait_until --verbose --delay 10 --retries 42 --check 'grep "Active: active (running)" | wc -l | grep 1' 'systemctl status rke2-server --no-pager'
  - export VAULT_ADDR=${vault_addr}
  - export VAULT_APP_TOKEN=$(vault write -format=json auth/approle/login role_id=${rke2_role_id} secret_id=${rke2_secret_id} | jq -r ".auth.client_token")
  - export IPV4=$(hostname -I | cut -d ' ' -f 1)
  - export RKE2_YAML=$(cat $RKE2_CONFIG_DIR/rke2.yaml | sed -e "s/127.0.0.1:6443/$IPV4:6443/" | base64 --wrap=0)
  - VAULT_TOKEN=$VAULT_APP_TOKEN vault kv put -mount=${vault_mount} ${vault_path} ${vault_field}="$RKE2_YAML"
