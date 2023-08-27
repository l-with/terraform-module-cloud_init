  - croc relay --ports ${vault_croc_ports} &
  - |
    export ipv4_address=$(ip addr show | grep 'inet ' | grep 'scope global' | cut -d ' ' -f6 | cut -d '/' -f 1)
  - croc --relay $ipv4_address:${vault_croc_port} send --code ${vault_croc_code_phrase} ${vault_init_json_enc_base64_full_path}
  - killall croc
