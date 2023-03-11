  - >
    while [ $(systemctl status rke2-server --no-pager | grep "Active: active (running)" | wc -l) != "1" ]; do sleep 5; done
  - export VAULT_ADDR=https://vault.with.de
  - export VAULT_APP_TOKEN=$(vault write -format=json auth/approle/login role_id=${rke2_role_id} secret_id=${rke2_secret_id} | jq -r ".auth.client_token")
  - export IPV4=$(hostname -I | cut -d ' ' -f 1)
  - export RKE2_YAML=$(cat $RKE2_CONFIG_DIR/rke2.yaml | sed -e "s/127.0.0.1:6443/$IPV4:6443/" | base64 --wrap=0)
  - VAULT_TOKEN=$VAULT_APP_TOKEN vault kv put -mount=gitlab rancher/kubeconfig rke2_yaml="$RKE2_YAML"
