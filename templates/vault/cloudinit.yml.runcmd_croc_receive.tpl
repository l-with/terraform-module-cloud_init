  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep 0' 'nc -z ${jsondecode(jsonencoded_vault_croc_receive_relay).address} ${jsondecode(jsonencoded_vault_croc_receive_relay).port}; echo $?'
  - croc --yes --relay ${jsondecode(jsonencoded_vault_croc_receive_relay).address}:${jsondecode(jsonencoded_vault_croc_receive_relay).port} '${vault_croc_code_phrase}'
